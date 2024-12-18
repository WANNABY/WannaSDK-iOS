// WANNA SDK
// Copyright © 2024 WANNABY Inc. All rights reserved.

import Foundation
import UIKit

@_exported import WsneakersUISDK

// SPM support
#if canImport(WannaTryOn_Toolkit)
@_exported import WannaTryOn_Toolkit
#endif

// Use this to create the view and manage its properties in code
@available(iOS 13.0, *)
open class TryOnViewController: UIViewController {
    open private(set) lazy var tryOnView: WsneakersUISDKView = {
        let view = WsneakersUISDKView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.supportedOrientationMask = .all

        return view
    }()

    var wsneakersSession: WannaSDKSession?

    @IBOutlet weak var videoRecordButton: UIButton!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var modelId: UILabel!
    @IBOutlet weak var handSelection: UISegmentedControl?

    private final var storage: WsneakersUISDKRenderModelStorage?
    private final var renderModels: [String] = []

    private var currentTask: WsneakersUISDKDownloadTask?
    private var currentIndex = 0
    private var videoRecordRunning = false

    deinit {
        wsneakersSession?.stop { _ in
        }
    }

    // MARK: - Override

    open override func viewDidLoad() {
        super.viewDidLoad()

        setupTryOnView()
        progress.isHidden = true

        loadModel(with: currentIndex)
        setupHandSelection()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Start showing the virtual try-on
        if let wsneakersSession, !wsneakersSession.isDrawing() {
            wsneakersSession.startDrawing()
        }
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        // Stop rendering the virtual try-on
        wsneakersSession?.stopDrawing()
    }
}

// MARK: - Dependency injection

@available(iOS 13.0, *)
public extension TryOnViewController {
    // Set the view to use the previously created session and storage objects,
    // and work with the list of 3D models with one already selected.
    func set(
        session: WannaSDKSession,
        storage: WsneakersUISDKRenderModelStorage,
        renderModels: [String],
        selected: Int
    ) {
        wsneakersSession = session
        wsneakersSession?.delegate = self
        currentIndex = selected

        self.storage = storage
        self.renderModels = renderModels

        session.start()

        setupHandSelection()
    }
}

// MARK: - Model selection

@MainActor
@available(iOS 13.0, *)
private extension TryOnViewController {
    @IBAction func onNextRenderModel(_ sender: Any) {
        var nextIndex = currentIndex + 1
        if (nextIndex == renderModels.count) {
            nextIndex = 0
        }

        loadModel(with: nextIndex)
    }

    @IBAction func onPreviousRenderModel(_ sender: Any) {
        var nextIndex = currentIndex - 1
        if (nextIndex < 0) {
            nextIndex = renderModels.count - 1
        }

        loadModel(with: nextIndex)
    }
}

@available(iOS 13.0, *)
private extension TryOnViewController {
    func setRenderModel(_ renderModel: WsneakersUISDKRenderModel, index: Int) {
        wsneakersSession?.change(renderModel) { [weak self] error in
            Task {
                guard let error else {
                    self?.onModelLoadFinished()
                    return
                }

                self?.onModelLoadFailed(error: error)
            }
        }
    }
}

extension TryOnViewController: WannaSDKSessionDelegate {
    public func sessionDidCaptureFrame(_ sampleBuffer: CMSampleBuffer, completion callback: @escaping (CMSampleBuffer) -> Void) {
        let image = createImage(from: sampleBuffer)

        guard let sampleBuffer = image?.createCMSampleBuffer() else { return }

        DispatchQueue.main.asyncAfter(deadline: .now()) {
            callback(sampleBuffer)
        }
    }

    func createImage(from sampleBuffer: CMSampleBuffer) -> UIImage? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            print("Failed to get image buffer from CMSampleBuffer.")
            return nil
        }

        CVPixelBufferLockBaseAddress(imageBuffer, .readOnly)
        defer { CVPixelBufferUnlockBaseAddress(imageBuffer, .readOnly) }

        let ciImage = CIImage(cvPixelBuffer: imageBuffer)
        let context = CIContext()

        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
            print("Failed to create CGImage from CIImage.")
            return nil
        }

        let image = UIImage(cgImage: cgImage)
        return image
    }
}

extension UIImage {
    func createCMSampleBuffer() -> CMSampleBuffer? {
        guard let cgImage = cgImage else {
            print("Failed to get CGImage from UIImage.")
            return nil
        }

        let width = cgImage.width
        let height = cgImage.height
        let pixelFormat = kCVPixelFormatType_32BGRA

        var pixelBuffer: CVPixelBuffer?

        let status = CVPixelBufferCreate(
            kCFAllocatorDefault,
            width,
            height,
            pixelFormat,
            nil,
            &pixelBuffer
        )

        guard status == kCVReturnSuccess, let buffer = pixelBuffer else {
            print("Failed to create CVPixelBuffer.")
            return nil
        }

        CVPixelBufferLockBaseAddress(buffer, .readOnly)
        defer { CVPixelBufferUnlockBaseAddress(buffer, .readOnly) }

        if let context = CGContext(
            data: CVPixelBufferGetBaseAddress(buffer),
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
            space: cgImage.colorSpace ?? CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue
        ) {
            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        } else {
            print("Failed to create CGContext.")
            return nil
        }

        var formatDescription: CMVideoFormatDescription?
        let result = CMVideoFormatDescriptionCreateForImageBuffer(
            allocator: kCFAllocatorDefault,
            imageBuffer: buffer,
            formatDescriptionOut: &formatDescription
        )

        guard result == noErr, let validFormatDescription = formatDescription else {
            print("Failed to create CMVideoFormatDescription.")
            return nil
        }

        // Create a CMSampleBuffer from the CVPixelBuffer
        var sampleBuffer: CMSampleBuffer?
        var timingInfo = CMSampleTimingInfo(duration: .invalid, presentationTimeStamp: .zero, decodeTimeStamp: .invalid)
        let sampleBufferResult = CMSampleBufferCreateForImageBuffer(
            allocator: kCFAllocatorDefault,
            imageBuffer: buffer,
            dataReady: true,
            makeDataReadyCallback: nil,
            refcon: nil,
            formatDescription: validFormatDescription,
            sampleTiming: &timingInfo,
            sampleBufferOut: &sampleBuffer
        )

        guard sampleBufferResult == noErr else {
            print("Failed to create CMSampleBuffer: \(sampleBufferResult)")
            return nil
        }

        return sampleBuffer
    }

    func sampleBuffer() -> CMSampleBuffer? {
        guard let jpegData = self.jpegData(compressionQuality: 1) else {
            return nil
        }

        let rawPixelSize = CGSize(width: size.width, height: size.height)

        var format: CMFormatDescription?

        _ = CMVideoFormatDescriptionCreate(allocator: kCFAllocatorDefault, codecType: kCMVideoCodecType_JPEG, width: Int32(rawPixelSize.width), height: Int32(rawPixelSize.height), extensions: nil, formatDescriptionOut: &format)

        do {
            let cmBlockBuffer = try createCMBlockBuffer(data: jpegData)
            var size = jpegData.count
            var sampleBuffer: CMSampleBuffer?
            let preciseTime = CMTimeMakeWithSeconds(CACurrentMediaTime(), preferredTimescale: 600)
            let rescaledTime = CMTimeConvertScale(preciseTime, timescale: 60, method: .default)
//            let nowTime = CMTime(seconds: CACurrentMediaTime(), preferredTimescale: 60)
            let preciseTime2 = CMTimeMakeWithSeconds(1, preferredTimescale: 600)
            let rescaledTime2 = CMTimeConvertScale(preciseTime2, timescale: 60, method: .default)
//            let _1_60_s = CMTime(value: 1, timescale: 60) // CMTime(seconds: 1.0, preferredTimescale: 30)
            var timingInfo: CMSampleTimingInfo = CMSampleTimingInfo(duration: rescaledTime2, presentationTimeStamp: rescaledTime, decodeTimeStamp: .invalid)
            _ = CMSampleBufferCreateReady(allocator: kCFAllocatorDefault, dataBuffer: cmBlockBuffer, formatDescription: format, sampleCount: 1, sampleTimingEntryCount: 1, sampleTimingArray: &timingInfo, sampleSizeEntryCount: 1, sampleSizeArray: &size, sampleBufferOut: &sampleBuffer)

            if sampleBuffer != nil {
                // print("sending buffer to displayBufferLayer")
                // self.bufferDisplayLayer.enqueue(sampleBuffer!)
                return sampleBuffer
            } else {
                return nil
            }
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }

    func createCMBlockBuffer(data: Data) throws -> CMBlockBuffer? {
        guard !data.isEmpty else {
            print("Data is empty. Cannot create CMBlockBuffer.")
            return nil
        }

        var blockBuffer: CMBlockBuffer?

        let status = data.withUnsafeBytes { rawBufferPointer -> OSStatus in
            guard let baseAddress = rawBufferPointer.baseAddress else {
                return 1  // Return an error code if baseAddress is nil
            }
            let mutablePointer = UnsafeMutableRawPointer(mutating: baseAddress)
            return CMBlockBufferCreateWithMemoryBlock(
                allocator: kCFAllocatorDefault,
                memoryBlock: mutablePointer,
                blockLength: data.count,
                blockAllocator: kCFAllocatorNull,
                customBlockSource: nil,
                offsetToData: 0,
                dataLength: data.count,
                flags: 0,
                blockBufferOut: &blockBuffer
            )
        }

        if status != kCMBlockBufferNoErr {
            print("Failed to create CMBlockBuffer: \(status)")
            return nil
        }

        return blockBuffer
    }
}

// MARK: - Model download

@MainActor
@available(iOS 13.0, *)
private extension TryOnViewController {
    func loadModel(with index: Int) {
        onModelLoadStarted()
        currentIndex = index

        // Clears the current model and shows the raw stream from camera
        // You can remove this line to leave the previous model on
        // while the new model is getting ready
        wsneakersSession?.removeRenderModel()

        // If any other download task was active, drop it
        currentTask?.cancel()

        // Downloads the new model, showing a progress indicator
        currentTask = storage?.getRenderModel(
            withID: renderModels[index],
            options: wsneakersSession?.options ?? []
        ) { [weak self] task, progress in
            guard task == self?.currentTask else {
                // Ignore progress from previously cancelled tasks
                return
            }

            Task {
                self?.updateProgress(progress)
            }
        } completion: { [weak self] renderModel, error in
            guard let renderModel else {
                Task {
                    self?.onModelLoadFailed(error: error)
                }

                return
            }

            self?.setRenderModel(renderModel, index: index)
        }
    }

    func onModelLoadStarted() {
        activity.startAnimating()
        title = "Loading model..."
    }

    func onModelLoadFinished() {
        progress.isHidden = true
        activity.stopAnimating()

        let id = renderModels[currentIndex]
        modelId.text = id
        title = "\(id) \(currentIndex + 1)/\(renderModels.count)"
    }

    func onModelLoadFailed(error: Error?) {
        let message = error?.localizedDescription ?? "Unexpected"

        showError(message:  "Model load failed: \(message)") { [weak self, currentIndex] in
            self?.loadModel(with: currentIndex)
        }

        onModelLoadFinished()
    }
}

// MARK: - Switch camera

@MainActor
@available(iOS 13.0, *)
private extension TryOnViewController {
    @IBAction func onSwitchCamera(_ sender: UIButton) {
        let position: WannaCameraPosition = wsneakersSession?.cameraPosition == .front ? .back : .front

        wsneakersSession?.switchCamera(to: position)
    }
}

// MARK: - Photo capturing

@MainActor
@available(iOS 13.0, *)
private extension TryOnViewController {
    @IBAction func onTakePhoto(_ sender: UIButton) {
        wsneakersSession?.captureStillPhoto { [weak self] image, error in
            Task {
                guard let image else {
                    self?.presentAlert(title: "Unable to capture photo", error: error)
                    return
                }

                self?.onPhotoCaptured(image: image)
            }
        }
    }

    func onPhotoCaptured(image: UIImage) {
        presentAlert(
            title: "Photo captured",
            message: "Do you want to save it to the camera roll?",
            actions: [
                .default(title: "Save") {
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                },
                .destructive(title: "Remove")
            ]
        )
    }
}

// MARK: - Video recording

@MainActor
@available(iOS 13.0, *)
private extension TryOnViewController {
    @IBAction func videoRecordButtonTouchedUpInside(_ sender: UIButton) {
        if videoRecordRunning {
            stopVideoRecording()
        } else {
            startVideoRecording()
        }
    }

    func startVideoRecording() {
        onVideoRecordingStarted()

        wsneakersSession?.startRecordingResultVideo(
            with: UIApplication.shared.interfaceOrientation ?? .portrait
        ) { [weak self] error in
            if let error {
                Task {
                    self?.onVideoRecordingFinished()
                    self?.presentAlert(title: "Unable to start recording", error: error)
                }
            }
        }
    }

    func stopVideoRecording() {
        wsneakersSession?.stopRecordingResultVideo { [weak self] url, error in
            Task {
                self?.onVideoRecordingFinished()

                guard let url else {
                    self?.presentAlert(title: "Unable to stop recording", error: error)
                    return
                }

                self?.onVideoRecorded(url: url)
            }
        }
    }

    func onVideoRecordingStarted() {
        videoRecordRunning = true
        videoRecordButton?.setTitle("Stop video recording", for: .normal)
    }

    func onVideoRecordingFinished() {
        videoRecordRunning = false
        videoRecordButton?.setTitle("Record video", for: .normal)
    }

    func onVideoRecorded(url: URL) {
        presentAlert(
            title: "Video recorded",
            message: "Do you want to save it to the camera roll?",
            actions: [
                .default(title: "Save") {
                    // Save Video to camera roll
                    UISaveVideoAtPathToSavedPhotosAlbum(url.path, nil, nil, nil)
                },
                .destructive(title: "Remove") {
                    // Remove the video file if you don't need it any more
                    let _ = try? FileManager.default.removeItem(at:url)
                }
            ]
        )
    }
}

// MARK: - TryOn View

@MainActor
@available(iOS 13.0, *)
private extension TryOnViewController {
    func setupTryOnView() {
        view.insertSubview(tryOnView, at: 0)

        // Connect the view to the session so the virtual try-on will be shown here
        wsneakersSession?.wsneakersUISDKView = tryOnView

        // 16х9
        tryOnView.heightAnchor.constraint(equalTo: tryOnView.widthAnchor, multiplier: 16.0/9.0).isActive = true

        // Vertical
        tryOnView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tryOnView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor).isActive = true

        // Horizontal
        tryOnView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor).isActive = true
        tryOnView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        // Corner cases
        [
            tryOnView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tryOnView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ].forEach {
            $0.isActive = true
            $0.priority = .defaultHigh
        }
    }
}

// MARK: - Progress

@MainActor
@available(iOS 13.0, *)
private extension TryOnViewController {
    func updateProgress(_ value: Float) {
        progress.isHidden = false
        progress.progress = value
    }
}

// MARK: - Switch hands
@available(iOS 13.0, *)
private extension TryOnViewController {

    func setupHandSelection() {
        handSelection?.isHidden = wsneakersSession?.category != .watch
    }

    // Action from segmented control for hand selection.
    @IBAction func onHandSelected(_ sender: UISegmentedControl) {
        // Segmented control UI: [ left | both | right ]
        let isLeftTracked = sender.selectedSegmentIndex < 2
        let isRightTracked = sender.selectedSegmentIndex > 0

        wsneakersSession?.configuration.tracking.watch.leftWristAnchor.isTracked = isLeftTracked
        wsneakersSession?.configuration.tracking.watch.rightWristAnchor.isTracked = isRightTracked
    }
}

// MARK: - Error handling

@MainActor
@available(iOS 13.0, *)
private extension TryOnViewController {
    func showError(message: String, retry: @escaping () -> Void) {
        presentAlert(
            title: "Error",
            message: message,
            actions: [
                .default(title: "Retry", handler: retry),
                .cancel
            ]
        )
    }
}
