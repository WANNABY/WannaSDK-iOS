//
//  WsneakersGeneralViewController.swift
//  WANNA SDK
//
//
//  Copyright © 2019 WANNABY Inc. All rights reserved.
//

import UIKit
import WsneakersUISDK

// Use this to create the view and manage its properties in code
class WsneakersGeneralViewController: UIViewController {
    lazy var wsneakersView: WsneakersUISDKView = {
        return createView()
    }()
    @IBOutlet weak var videoRecordButton: UIButton!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var progress: UIProgressView!

    private final var wsneakersSession: WsneakersUISDKSession!
    private final var storage: WsneakersUISDKRenderModelStorage!
    private final var renderModels: [WsneakersUISDKModelInfo]!
    private var currentIndex = 0
    private var videoRecordRunning = false

    func createView() -> WsneakersUISDKView {
        let sneakersView = WsneakersUISDKView()
        view.insertSubview(sneakersView, at: 0)
        sneakersView.translatesAutoresizingMaskIntoConstraints = false
        sneakersView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        sneakersView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        sneakersView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        sneakersView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        return sneakersView
    }

    // Set the view to use the previously created session and storage objects, 
    // and work with the list of 3D models with one already selecteds
    func set(session: WsneakersUISDKSession, storage: WsneakersUISDKRenderModelStorage, renderModels: [WsneakersUISDKModelInfo], selected: Int) {
        self.wsneakersSession = session
        self.storage = storage
        self.renderModels = renderModels
        currentIndex = selected
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        progress.isHidden = true
        wsneakersView.supportedOrientationMask = .all
        // Connect the view to the session so the virtual try-on will be shown here
        wsneakersSession.wsneakersUISDKView = wsneakersView

        loadModel(with: currentIndex)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Start showing the virtual try-on
        if !wsneakersSession.isDrawing() {
            wsneakersSession.startDrawing()
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        // Stop rendering the virtual try-on
        wsneakersSession.stopDrawing()
    }

    private func showError(with title: String, retry: @autoclosure @escaping () -> ()) {
        let popup = UIAlertController(title: "Error", message: title, preferredStyle: .alert)
        popup.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        popup.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
            retry()
        }))
        DispatchQueue.main.async { [weak self] in
            guard let sSelf = self else { return }
            sSelf.present(popup, animated: true)
        }
    }

    private func setRenderModel(_ renderModel: WsneakersUISDKRenderModel, index: Int) {
        title = "Launching"
        wsneakersSession.change(renderModel) { [weak self] error in
            DispatchQueue.main.async {
                guard let sSelf = self else { return }
                sSelf.title = ""
                sSelf.activity.stopAnimating()
                if let _ = error {
                    sSelf.showError(with: "Loading failed", retry: sSelf.setRenderModel(renderModel, index: index))
                    return
                }
            }
        }
    }

    private var currentTask: WsneakersUISDKDownloadTask?

    private func loadModel(with index: Int) {
        activity.startAnimating()
        title = "Downloading"
        // If any other download task was active, drop it
        currentTask?.cancel()
        // Clears the current model and shows the raw stream from camera 
        // You can remove this line to leave the previous model on
        // while the new model is getting ready
        wsneakersSession.removeRenderModel()
        self.currentIndex = index
        // Downloads the new model, showing a progress indicator
        currentTask = storage.getRenderModel(withID: renderModels[index].renderModelID,
                                             progress: { [weak self] task, progress in
                                                if let cur = self?.currentTask, task == cur {
                                                    DispatchQueue.main.async {
                                                        self?.progress.isHidden = false
                                                        self?.progress.progress = progress
                                                    }
                                                }
        }) { [weak self] (renderModel, error) in
            DispatchQueue.main.async {
                guard let sSelf = self else { return }
                sSelf.progress.isHidden = true
                if let _ = error {
                    sSelf.title = ""
                    sSelf.activity.stopAnimating()
                    sSelf.showError(with: "Downloading failed", retry: sSelf.loadModel(with: index))
                    return
                }
                // Sets the new 3D model to show in the virtual try-on
                sSelf.setRenderModel(renderModel!, index: index)
            }
        }
    }

    @IBAction func onNextRenderModel(_ sender: Any) {
        var nextIndex = currentIndex + 1;
        if (nextIndex == renderModels.count) {
            nextIndex = 0
        }
        loadModel(with: nextIndex);
    }

    // This is where we manage recording the virtual try-ons
    @IBAction func videoRecordButtonTouchedUpInside(_ sender: UIButton) {
        sender.isEnabled = false;

        if (self.videoRecordRunning) {
            wsneakersSession.stopRecordingResultVideo { [weak self] (videoURL, error) in
                guard let sself = self else { return }

                DispatchQueue.main.async {
                    sender.isEnabled = true;

                    sself.videoRecordRunning = false;
                    sender.setTitle("Start Recording", for: UIControl.State.normal);

                    if error != nil {
                        NSLog("Unable to stop recording: \(error!.localizedDescription)");
                        return
                    }
                    NSLog("Video recording done: \(videoURL?.absoluteString ?? "nil")");

                    // Remove the video file if you don't need it any more
                    let _ = try? FileManager.default.removeItem(at:videoURL!);
                }
            }
        } else {
            wsneakersSession?.startRecordingResultVideo(with: UIApplication.shared.statusBarOrientation, completion: { [weak self] (error) in
                guard let sself = self else { return }

                DispatchQueue.main.async {
                    sender.isEnabled = true;

                    if error != nil {
                        NSLog("Unable to stop recording: \(error!.localizedDescription)");
                        return
                    }

                    NSLog("Video recording started");
                    sself.videoRecordRunning = true;
                    sender.setTitle("Stop Recording", for: UIControl.State.normal);
                }
            })
        }
    }

    // This is where we manage taking screenshots of the virtual try-on
    @IBAction func onTakePhoto(_ sender: UIButton) {
        wsneakersSession.captureStillPhoto { (image, error) in
            guard let _ = image else { print("Screenshot failed"); return }
            print("Screenshot saved")
        }
    }
}
