import Foundation
import UIKit
import SwiftUI
import os

// Object Capture (ObjectCaptureSession/View + PhotogrammetrySession) exists only
// in the *device* SDK — the iOS Simulator SDK doesn't ship these symbols, so the
// no-codesign simulator CI build must exclude them. Everything RealityKit-backed
// is gated on `canImport(RealityKit) && !targetEnvironment(simulator)`; on the
// simulator the scan fails gracefully.
#if canImport(RealityKit) && !targetEnvironment(simulator)
import RealityKit
#endif

/// Phase 6 — Apple Object Capture (iOS 17+ device). Guides the user through
/// capturing a single object, then runs an on-device `PhotogrammetrySession` at
/// `.reduced` detail and returns the resulting `.usdz`.
///
/// Result handed back to the `andoza/roomscan` channel:
///   `{usdzPath: String}` on success, `nil` on cancel, `FlutterError` on failure.
///
/// NOTE (verification): builds on CI (simulator path excludes it) and runs on a
/// real device via TestFlight; the capture UX is refined on-device. State is
/// driven off `session.stateUpdates` (async sequence), not SwiftUI `onChange`, so
/// it doesn't depend on `CaptureState: Equatable`. os_log at every transition.
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

  private let imagesDir: URL
  private let checkpointDir: URL
  private let outputURL: URL

  #if canImport(RealityKit) && !targetEnvironment(simulator)
  private var session: ObjectCaptureSession?
  private var stateTask: Task<Void, Never>?
  #endif

  init(completion: @escaping (ObjectScanOutcome) -> Void) {
    self.completion = completion
    let base = FileManager.default.temporaryDirectory
      .appendingPathComponent("objectscan-\(UUID().uuidString)", isDirectory: true)
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
    #if canImport(RealityKit) && !targetEnvironment(simulator)
    startObjectCapture()
    #else
    os_log("object capture unavailable (simulator / no RealityKit)", log: Self.log, type: .error)
    finish(.failed("3D buyum skaneri bu qurilmada mavjud emas"))
    #endif
  }

  #if canImport(RealityKit) && !targetEnvironment(simulator)
  private func startObjectCapture() {
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

    // Drive completion/failure off the async state stream — no reliance on
    // CaptureState being Equatable (SwiftUI onChange would need that).
    stateTask = Task { [weak self] in
      for await state in session.stateUpdates {
        guard let self else { return }
        switch state {
        case .completed:
          os_log("object capture completed → photogrammetry", log: Self.log, type: .info)
          await MainActor.run { self.startPhotogrammetry() }
          return
        case .failed(let error):
          os_log("object capture failed: %{public}@", log: Self.log, type: .error,
                 error.localizedDescription)
          await MainActor.run { self.finish(.failed(error.localizedDescription)) }
          return
        default:
          break
        }
      }
    }

    let host = UIHostingController(rootView: ObjectScanContainer(
      session: session,
      onCancel: { [weak self] in self?.handleCancel() }
    ))
    addChild(host)
    host.view.frame = view.bounds
    host.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.addSubview(host.view)
    host.didMove(toParent: self)
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
    #if canImport(RealityKit) && !targetEnvironment(simulator)
    stateTask?.cancel()
    stateTask = nil
    session = nil
    #endif
    dismiss(animated: true) { [weak self] in
      self?.completion(outcome)
    }
  }

  deinit { os_log("deinit", log: Self.log, type: .info) }
}

#if canImport(RealityKit) && !targetEnvironment(simulator)
/// SwiftUI container: the live ObjectCaptureView + an Uzbek guidance overlay and
/// the flow buttons (Detect → Capture → Done). Reads `session.state` via a
/// `switch` only (ObjectCaptureSession is @Observable, so the body re-renders on
/// change without needing `onChange`/Equatable).
@available(iOS 17.0, *)
private struct ObjectScanContainer: View {
  @State var session: ObjectCaptureSession
  let onCancel: () -> Void

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
          primaryButton
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
  }

  /// The stage's primary action, chosen by a switch over the capture state.
  @ViewBuilder private var primaryButton: some View {
    switch session.state {
    case .ready:
      actionButton("Aniqlash") { _ = session.startDetecting() }
    case .detecting:
      actionButton("Suratga olish") { session.startCapturing() }
    case .capturing:
      actionButton("Tayyor") { session.finish() }
    default:
      EmptyView()
    }
  }

  private func actionButton(_ title: String, _ action: @escaping () -> Void) -> some View {
    Button(title, action: action)
      .padding(10)
      .background(.blue, in: Capsule())
      .foregroundStyle(.white)
  }

  /// Short Uzbek guidance per state; warns it takes minutes + needs a well-lit,
  /// matte object.
  private var hint: String {
    switch session.state {
    case .initializing:
      return "Tayyorlanmoqda…"
    case .ready:
      return "Buyumga kamerani qarating. Yaxshi yoritilgan, yaltiroq bo'lmagan buyum tanlang, so'ng “Aniqlash” bosing."
    case .detecting:
      return "Buyumni ramka ichiga oling, so'ng “Suratga olish” bosing."
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
