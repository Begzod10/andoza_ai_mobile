import Foundation
import UIKit
import SwiftUI
import os

#if canImport(RealityKit)
import RealityKit
#endif

/// Phase 6 — Apple Object Capture (iOS 17+). Guides the user through capturing a
/// single object, then runs an on-device `PhotogrammetrySession` at `.reduced`
/// detail and returns the resulting `.usdz`.
///
/// Result shape handed back to the `andoza/roomscan` channel:
///   `{usdzPath: String}` on success, `nil` on cancel, `FlutterError` on failure.
///
/// NOTE (verification): the whole iOS story builds on CI / runs on TestFlight —
/// this file compiles behind `@available(iOS 17, *)` + `canImport(RealityKit)`
/// and follows Apple's ObjectCaptureSession → PhotogrammetrySession flow, but the
/// capture UX is best refined on a real device. Every state transition logs via
/// `os_log` (subsystem `uz.andoza.roomscan`) so TestFlight console logs are useful.
enum ObjectScanOutcome {
  case success(usdzPath: String)
  case cancelled
  case failed(String)
}

@available(iOS 17.0, *)
final class ObjectScanViewController: UIViewController {
  private static let log = OSLog(subsystem: "uz.andoza.roomscan", category: "objectscan")

  private let completion: (ObjectScanOutcome) -> Void
  private var didComplete = false

  #if canImport(RealityKit)
  private var session: ObjectCaptureSession?
  #endif

  /// Working dirs for this capture — images in, model out.
  private let workDir: URL
  private let imagesDir: URL
  private let checkpointDir: URL
  private let outputURL: URL

  init(completion: @escaping (ObjectScanOutcome) -> Void) {
    self.completion = completion
    let base = FileManager.default.temporaryDirectory
      .appendingPathComponent("objectscan-\(UUID().uuidString)", isDirectory: true)
    self.workDir = base
    self.imagesDir = base.appendingPathComponent("Images", isDirectory: true)
    self.checkpointDir = base.appendingPathComponent("Checkpoint", isDirectory: true)
    self.outputURL = base.appendingPathComponent("model.usdz")
    super.init(nibName: nil, bundle: nil)
    modalPresentationStyle = .fullScreen
  }

  required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    os_log("viewDidLoad", log: Self.log, type: .info)

    #if canImport(RealityKit)
    guard ObjectCaptureSession.isSupported else {
      os_log("object capture unsupported on this device", log: Self.log, type: .error)
      finish(.failed("Bu qurilma 3D buyum skanerlashni qo'llab-quvvatlamaydi"))
      return
    }
    do {
      try FileManager.default.createDirectory(at: imagesDir, withIntermediateDirectories: true)
      try FileManager.default.createDirectory(at: checkpointDir, withIntermediateDirectories: true)
    } catch {
      finish(.failed("Papka yaratib bo'lmadi: \(error.localizedDescription)"))
      return
    }

    let session = ObjectCaptureSession()
    self.session = session
    var config = ObjectCaptureSession.Configuration()
    config.checkpointDirectory = checkpointDir
    session.start(imagesDirectory: imagesDir, configuration: config)

    // Host the SwiftUI capture UI + a top bar / Uzbek guidance overlay.
    let host = UIHostingController(rootView: ObjectScanContainer(
      session: session,
      onCancel: { [weak self] in self?.handleCancel() },
      onFinishRequested: { [weak self] in self?.handleFinishRequested() },
      onReconstructionDone: { [weak self] in self?.startPhotogrammetry() }
    ))
    addChild(host)
    host.view.frame = view.bounds
    host.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.addSubview(host.view)
    host.didMove(toParent: self)
    #else
    finish(.failed("RealityKit mavjud emas"))
    #endif
  }

  #if canImport(RealityKit)
  private func handleFinishRequested() {
    os_log("user finished capture pass — session.finish()", log: Self.log, type: .info)
    session?.finish()
    // ObjectScanContainer observes session.state == .completed and calls
    // onReconstructionDone → startPhotogrammetry().
  }

  private func startPhotogrammetry() {
    os_log("starting PhotogrammetrySession (.reduced)", log: Self.log, type: .info)
    var photoConfig = PhotogrammetrySession.Configuration()
    photoConfig.checkpointDirectory = checkpointDir
    let request = PhotogrammetrySession.Request.modelFile(url: outputURL, detail: .reduced)
    do {
      let photoSession = try PhotogrammetrySession(input: imagesDir, configuration: photoConfig)
      Task { [weak self] in
        guard let self else { return }
        do {
          try photoSession.process(requests: [request])
          for try await output in photoSession.outputs {
            switch output {
            case .requestProgress(_, let fraction):
              os_log("photogrammetry progress %.2f", log: Self.log, type: .info, fraction)
            case .processingComplete:
              os_log("photogrammetry complete", log: Self.log, type: .info)
              await MainActor.run { self.finish(.success(usdzPath: self.outputURL.path)) }
              return
            case .requestError(_, let error):
              await MainActor.run { self.finish(.failed(error.localizedDescription)) }
              return
            default:
              break
            }
          }
        } catch {
          await MainActor.run { self.finish(.failed(error.localizedDescription)) }
        }
      }
    } catch {
      finish(.failed("Fotogrammetriya boshlanmadi: \(error.localizedDescription)"))
    }
  }
  #endif

  private func handleCancel() {
    os_log("cancel", log: Self.log, type: .info)
    finish(.cancelled)
  }

  private func finish(_ outcome: ObjectScanOutcome) {
    guard !didComplete else { return }
    didComplete = true
    #if canImport(RealityKit)
    session = nil
    #endif
    dismiss(animated: true) { [weak self] in
      self?.completion(outcome)
    }
  }

  deinit { os_log("deinit", log: Self.log, type: .info) }
}

#if canImport(RealityKit)
/// SwiftUI container: the live ObjectCaptureView + an Uzbek guidance/progress
/// overlay + top-bar Cancel / Done. Drives the capture state machine.
@available(iOS 17.0, *)
private struct ObjectScanContainer: View {
  let session: ObjectCaptureSession
  let onCancel: () -> Void
  let onFinishRequested: () -> Void
  let onReconstructionDone: () -> Void

  @State private var didRequestReconstruct = false

  var body: some View {
    ZStack {
      ObjectCaptureView(session: session)
        .ignoresSafeArea()

      VStack {
        HStack {
          Button("Bekor qilish", action: onCancel)
            .padding(10)
            .background(.black.opacity(0.5), in: Capsule())
            .foregroundStyle(.white)
          Spacer()
          if session.state == .capturing {
            Button("Tayyor", action: onFinishRequested)
              .padding(10)
              .background(.blue, in: Capsule())
              .foregroundStyle(.white)
          }
        }
        .padding()
        Spacer()
        Text(hint)
          .font(.footnote)
          .multilineTextAlignment(.center)
          .foregroundStyle(.white)
          .padding(12)
          .background(.black.opacity(0.5), in: RoundedRectangle(cornerRadius: 12))
          .padding(.bottom, 24)
          .padding(.horizontal, 24)
      }
    }
    .onChange(of: session.state) { _, newState in
      // When reconstruction/finish completes, kick off photogrammetry once.
      if newState == .completed && !didRequestReconstruct {
        didRequestReconstruct = true
        onReconstructionDone()
      }
    }
  }

  /// Short Uzbek guidance mapped from the session state; warns that it takes a
  /// few minutes and needs a well-lit, matte object.
  private var hint: String {
    switch session.state {
    case .initializing:
      return "Tayyorlanmoqda…"
    case .ready:
      return "Buyumga kamerani qarating. Yaxshi yoritilgan, yaltiroq bo'lmagan buyum tanlang."
    case .detecting:
      return "Buyumni ramka ichiga oling."
    case .capturing:
      return "Buyum atrofida sekin aylaning. Tugatgach “Tayyor” bosing. Bu bir necha daqiqa olishi mumkin."
    case .finishing:
      return "Yakunlanmoqda…"
    case .completed:
      return "3D model tayyorlanmoqda… (bir necha daqiqa)"
    case .failed:
      return "Skanerlashda xatolik."
    @unknown default:
      return ""
    }
  }
}
#endif
