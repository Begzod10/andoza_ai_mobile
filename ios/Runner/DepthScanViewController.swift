import ARKit
import AVFoundation
import SceneKit
import UIKit

/// Outcome of a room scan, handed back to `LidarMethodChannel`.
enum DepthScanOutcome {
    case success(width: Double, length: Double, height: Double, pointCount: Int, durationMs: Int)
    /// `code` mirrors the Android error codes: CANCELLED / PERMISSION_DENIED /
    /// UNSUPPORTED / SCAN_FAILED.
    case failure(code: String, message: String)
}

/// Real ARKit room-scanning screen — the iOS counterpart of Android's
/// `DepthScanActivity`.
///
/// Runs a live `ARSession` with horizontal + vertical plane detection (and
/// LiDAR scene reconstruction where the device has it), renders the camera
/// feed with detected planes highlighted, and accumulates room dimensions in
/// `RoomMeasurer`. The user taps "Tayyor" to finish with the measurements, or
/// "Bekor qilish" to cancel.
final class DepthScanViewController: UIViewController {

    /// Called exactly once with the scan outcome; the controller dismisses
    /// itself first so the presenter does not have to.
    private let completion: (DepthScanOutcome) -> Void

    private let sceneView = ARSCNView(frame: .zero)
    private let measurer = RoomMeasurer()

    private let statusLabel = UILabel()
    private let hintLabel = UILabel()
    private let doneButton = UIButton(type: .system)
    private let cancelButton = UIButton(type: .system)

    private var startTime = Date()
    /// Set once an outcome has been delivered, to avoid double-completing.
    private var didComplete = false
    /// Planes currently tracked, for the status readout.
    private var trackedPlaneCount = 0

    /// Enough of the room seen to produce a usable measurement.
    private var hasUsableMeasurement: Bool {
        measurer.width > 0 && measurer.length > 0
    }

    init(completion: @escaping (DepthScanOutcome) -> Void) {
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .fullScreen
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUpSceneView()
        setUpOverlay()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requestCameraAccessAndStart()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    override var prefersStatusBarHidden: Bool { true }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .portrait }

    // MARK: - Setup

    private func setUpSceneView() {
        sceneView.translatesAutoresizingMaskIntoConstraints = false
        sceneView.delegate = self
        sceneView.session.delegate = self
        sceneView.automaticallyUpdatesLighting = true
        view.addSubview(sceneView)
        NSLayoutConstraint.activate([
            sceneView.topAnchor.constraint(equalTo: view.topAnchor),
            sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    private func setUpOverlay() {
        statusLabel.text = "Tayyorlanmoqda..."
        statusLabel.textColor = .white
        statusLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 2
        statusLabel.translatesAutoresizingMaskIntoConstraints = false

        hintLabel.text = "Telefonni sekin harakatlantiring"
        hintLabel.textColor = UIColor.white.withAlphaComponent(0.75)
        hintLabel.font = .systemFont(ofSize: 13, weight: .regular)
        hintLabel.textAlignment = .center
        hintLabel.numberOfLines = 2
        hintLabel.translatesAutoresizingMaskIntoConstraints = false

        let statusStack = UIStackView(arrangedSubviews: [statusLabel, hintLabel])
        statusStack.axis = .vertical
        statusStack.spacing = 4
        statusStack.translatesAutoresizingMaskIntoConstraints = false
        statusStack.isLayoutMarginsRelativeArrangement = true
        statusStack.layoutMargins = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        statusStack.backgroundColor = UIColor.black.withAlphaComponent(0.45)
        statusStack.layer.cornerRadius = 16
        statusStack.clipsToBounds = true

        configure(cancelButton, title: "Bekor qilish", background: UIColor.white.withAlphaComponent(0.18))
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)

        // Orange to match the app's accent on the Flutter scanning screen.
        configure(doneButton, title: "Tayyor", background: UIColor(red: 1.0, green: 0.42, blue: 0.11, alpha: 1.0))
        doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        setDoneEnabled(false)

        let buttons = UIStackView(arrangedSubviews: [cancelButton, doneButton])
        buttons.axis = .horizontal
        buttons.distribution = .fillEqually
        buttons.spacing = 12
        buttons.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(statusStack)
        view.addSubview(buttons)

        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            statusStack.topAnchor.constraint(equalTo: guide.topAnchor, constant: 16),
            statusStack.leadingAnchor.constraint(greaterThanOrEqualTo: guide.leadingAnchor, constant: 16),
            statusStack.trailingAnchor.constraint(lessThanOrEqualTo: guide.trailingAnchor, constant: -16),
            statusStack.centerXAnchor.constraint(equalTo: guide.centerXAnchor),

            buttons.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            buttons.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16),
            buttons.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -16),
            buttons.heightAnchor.constraint(equalToConstant: 52),
        ])
    }

    private func configure(_ button: UIButton, title: String, background: UIColor) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = background
        button.layer.cornerRadius = 14
        button.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setDoneEnabled(_ enabled: Bool) {
        doneButton.isEnabled = enabled
        doneButton.alpha = enabled ? 1.0 : 0.45
    }

    // MARK: - Session

    private func requestCameraAccessAndStart() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            startSession()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                DispatchQueue.main.async {
                    guard let self else { return }
                    if granted {
                        self.startSession()
                    } else {
                        self.finish(with: .failure(
                            code: "PERMISSION_DENIED",
                            message: "Kamera uchun ruxsat berilmadi"
                        ))
                    }
                }
            }
        case .denied, .restricted:
            finish(with: .failure(code: "PERMISSION_DENIED", message: "Kamera uchun ruxsat berilmadi"))
        @unknown default:
            finish(with: .failure(code: "PERMISSION_DENIED", message: "Kamera uchun ruxsat berilmadi"))
        }
    }

    private func startSession() {
        guard ARWorldTrackingConfiguration.isSupported else {
            finish(with: .failure(code: "UNSUPPORTED", message: "Bu qurilma AR skanerlashni qo'llab-quvvatlamaydi"))
            return
        }

        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal, .vertical]
        configuration.environmentTexturing = .none

        // LiDAR devices additionally build a mesh, which makes plane extents
        // converge much faster and gives a real point count.
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            configuration.sceneReconstruction = .mesh
        }
        if ARWorldTrackingConfiguration.supportsFrameSemantics(.sceneDepth) {
            configuration.frameSemantics.insert(.sceneDepth)
        }

        startTime = Date()
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        statusLabel.text = "Xonani skanerlang"
    }

    // MARK: - Actions

    @objc private func cancelTapped() {
        finish(with: .failure(code: "CANCELLED", message: "Skanerlash bekor qilindi"))
    }

    @objc private func doneTapped() {
        guard hasUsableMeasurement else {
            statusLabel.text = "Hali yetarli ma'lumot yo'q — pol ko'rinishiga qarating"
            return
        }
        let durationMs = Int(Date().timeIntervalSince(startTime) * 1000)
        finish(with: .success(
            width: measurer.width,
            length: measurer.length,
            height: measurer.finalizedHeight(),
            pointCount: measurer.pointCount,
            durationMs: durationMs
        ))
    }

    /// Delivers the outcome once, after dismissing self.
    private func finish(with outcome: DepthScanOutcome) {
        guard !didComplete else { return }
        didComplete = true
        sceneView.session.pause()
        dismiss(animated: true) { [completion] in
            completion(outcome)
        }
    }

    // MARK: - Status

    private func refreshStatus() {
        guard !didComplete else { return }
        setDoneEnabled(hasUsableMeasurement)

        if hasUsableMeasurement {
            statusLabel.text = String(
                format: "%.2f × %.2f m · balandlik %.2f m",
                measurer.width, measurer.length, measurer.finalizedHeight()
            )
            hintLabel.text = "Tugatish uchun \"Tayyor\" ni bosing"
        } else if trackedPlaneCount > 0 {
            statusLabel.text = "Yuzalar topilmoqda (\(trackedPlaneCount))"
            hintLabel.text = "Telefonni sekin harakatlantiring"
        }
    }
}

// MARK: - ARSCNViewDelegate

extension DepthScanViewController: ARSCNViewDelegate {

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let plane = anchor as? ARPlaneAnchor else { return }
        DispatchQueue.main.async {
            self.trackedPlaneCount += 1
            self.measurer.ingest(plane)
            self.refreshStatus()
        }
        node.addChildNode(makePlaneNode(for: plane))
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let plane = anchor as? ARPlaneAnchor else { return }
        DispatchQueue.main.async {
            self.measurer.ingest(plane)
            self.refreshStatus()
        }
        // Keep the visualization in step with the refined extent.
        node.childNodes.forEach { $0.removeFromParentNode() }
        node.addChildNode(makePlaneNode(for: plane))
    }

    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor else { return }
        DispatchQueue.main.async {
            self.trackedPlaneCount = max(0, self.trackedPlaneCount - 1)
            self.refreshStatus()
        }
    }

    /// Translucent orange overlay so the user can see what has been captured.
    private func makePlaneNode(for plane: ARPlaneAnchor) -> SCNNode {
        let geometry: SCNGeometry
        if let planeGeometry = ARSCNPlaneGeometry(device: sceneView.device ?? MTLCreateSystemDefaultDevice()!) {
            planeGeometry.update(from: plane.geometry)
            geometry = planeGeometry
        } else {
            geometry = SCNPlane(width: 0.1, height: 0.1)
        }
        geometry.firstMaterial?.diffuse.contents =
            UIColor(red: 1.0, green: 0.42, blue: 0.11, alpha: 0.28)
        geometry.firstMaterial?.isDoubleSided = true

        let node = SCNNode(geometry: geometry)
        node.opacity = 0.9
        return node
    }
}

// MARK: - ARSessionDelegate

extension DepthScanViewController: ARSessionDelegate {

    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        // Raw feature points are the closest analogue to ARCore's point cloud
        // and give the coverage number reported back to Dart.
        if let points = frame.rawFeaturePoints?.points.count, points > 0 {
            measurer.addPoints(count: points)
        }
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.finish(with: .failure(
                code: "SCAN_FAILED",
                message: error.localizedDescription
            ))
        }
    }

    func sessionWasInterrupted(_ session: ARSession) {
        DispatchQueue.main.async {
            guard !self.didComplete else { return }
            self.statusLabel.text = "Skanerlash to'xtatildi"
        }
    }

    func sessionInterruptionEnded(_ session: ARSession) {
        DispatchQueue.main.async {
            guard !self.didComplete else { return }
            self.statusLabel.text = "Xonani skanerlang"
        }
    }
}
