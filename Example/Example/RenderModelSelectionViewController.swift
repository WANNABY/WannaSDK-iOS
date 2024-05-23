//
//  RenderModelSelectionViewController.swift
//  WANNA SDK
//
//
//  Copyright © 2019 WANNABY Inc. All rights reserved.
//

// TODO: Add models list to separate module
// https://wannaby.atlassian.net/browse/WK-10476

import UIKit
import WannaTryOn

enum RenderableType: String {
    case watch
    case sneaker
    case clothes
}

class RenderModelSelectionViewController: UIViewController {
    // In this example, we demonstrate both kinds of UI view creating:
    // in code or via the storyboard
    // Keep the one you prefer if you're writing your app based on this example
    enum ViewType: String {
        case manual = "RemoteManualTryOn"
        case xib = "RemoteTryOn"
    }

    private var viewType: ViewType?

    private var storage: WsneakersUISDKRenderModelStorage?
    private var renderableType: RenderableType!

    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    // We'll try to preload the models and put them in cache
    // to improve waiting times during virtual try-on
    // In this example, we simply preload the first three models from the list
    private var renderModels = [WsneakersUISDKModelInfo]() {
        didSet {
            guard !renderModels.isEmpty else { return }
            renderModels
                .prefix(3)
                .forEach { model in
                    storage?.preloadRenderModel(withID: model.renderModelID, progress: nil) { res, error in
                        if res {
                            print("model preloaded: " + model.renderModelID)
                        } else {
                            print("model preload failed: " + error!.localizedDescription)
                        }
                    }
                }
        }
    }

    private var wsneakersSession: WannaSDKSession?

    deinit {
        wsneakersSession?.stop { _ in

        }
    }
    
    func setRenderableType(type: RenderableType) {
        renderableType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if renderModels.isEmpty {
            loadRenderModels()
        }

        wsneakersSession = nil
    }
 
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("device did clear cache after shaking")
            storage?.clearCache()
        }
    }
}

// Putting the model IDs into a table where the user can choose which one to try on
extension RenderModelSelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return renderModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath);
        cell.textLabel?.text = renderModels[indexPath.row].renderModelID
        return cell
    }
}

extension RenderModelSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activity.startAnimating()
        loadNewSession(completion: { [weak self] session in
            guard let session = session else {
                DispatchQueue.main.async {
                    self?.activity.stopAnimating()
                }
                return
            }
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.activity.stopAnimating()
                self.openTryon(session: session, index: indexPath.row)
            }
        })

        tableView.deselectRow(at: indexPath, animated: false)
    }
}

//New session creation
private extension RenderModelSelectionViewController {
    func loadNewSession(completion: @escaping (WannaSDKSession?) -> ()) {
        waitForPreviousSessionDestroy { [weak self] in
            self?.createSession(completion: completion)
        }
    }
    
    func waitForPreviousSessionDestroy(completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            var isLocked: Bool

            repeat {
                isLocked = !WsneakersUISDKSession.waitForSessionDestroy(withTimeout: 0.100)
            } while isLocked && self != nil

            completion()
        }
    }

    func createSession(type: RenderableType) throws -> WannaSDKSession {
        switch type {
        case .watch:
            return try createWatchSession()
        case .sneaker:
            return try createSneakersSession()
        case .clothes:
            return try createClothesSession()
        }
    }
    
    func createSession(completion: @escaping (WannaSDKSession?) -> ()) {
        if let session = wsneakersSession {
            completion(session)
            return
        }
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let sSelf = self else { return }
            do {
                let session = try sSelf.createSession(type: sSelf.renderableType) // this is where we create the new session

                // Checking for camera permissions here
                // We need authorization for the video stream from camera to do virtual try-on
                let status = AVCaptureDevice.authorizationStatus(for: .video)
                switch status {
                case .notDetermined:
                    AVCaptureDevice.requestAccess(for: .video) { hasAccess in
                        session.start()
                        sSelf.wsneakersSession = session
                        if !hasAccess {
                            sSelf.showCameraPermissions()
                        }
                        completion(hasAccess ? session : nil)
                    }
                case .authorized:
                    session.start()
                    sSelf.wsneakersSession = session
                    completion(session)
                default:
                    sSelf.showCameraPermissions()
                    completion(nil)
                }
            } catch {
                sSelf.showError(message: "Unable to create a session", retry: {
                    self?.createSession(completion: completion)
                }, cancel: {
                    completion(nil)
                })
            }
        }
    }
    
    func createWatchSession() throws -> WannaSDKSession {
        try WsneakersUISDKSession.createWatch(withConfig: WannaSDKDefaults.clientConfig, progress: { progress in
            return true
        })
    }

    func createSneakersSession() throws -> WannaSDKSession {
        try WsneakersUISDKSession.createSession(withConfig: WannaSDKDefaults.clientConfig, progress: { progress in
            return true
        })
    }

    func createClothesSession() throws -> WannaSDKSession {
        try WsneakersUISDKSession.createClothesSession(withConfig: WannaSDKDefaults.clientConfig, progress: { progress in
            return true
        })
    }
}

private extension RenderModelSelectionViewController {
    func loadRenderModels() {
        activity.startAnimating()
        // This is where we create the model storage
        // that will load and set the models to virtual try-on
        do {
            storage = try WsneakersUISDKRenderModelStorage.createStorage(withConfig: WannaSDKDefaults.clientConfig,
                                                                         cacheSize: WannaSDKDefaults.cacheSize)
        } catch {
            activity.stopAnimating()
            var description = error.localizedDescription

            // Checking for the correct license info
            // Don't forget to enter your configuration string in WannaSDKDefaults.swift
            if WannaSDKDefaults.clientConfig.isEmpty {
                description = "Please change the config string in WannaSDKDefaults.swift"
            }

            showError(message: description) { [weak self] in
                self?.loadRenderModels()
            } cancel: {}
        }

        // Listing the models available to your client ID
        storage?.loadModels { [weak self] (renderModels, error) in
            DispatchQueue.main.async {
                guard let sSelf = self else { return }

                sSelf.activity.stopAnimating()
                if let _ = error {
                    sSelf.showError(message: "Request Failed", retry: {
                        self?.loadRenderModels()
                    }, cancel: {

                    })
                    return
                }

                sSelf.renderModels = renderModels!
                    .filter { $0.renderModelType == sSelf.renderableType.rawValue }
                    .sorted { $0.renderModelID < $1.renderModelID }

                sSelf.tableView.reloadData()
            }
        }
    }

    // We need camera permissions for the virtual try-on to work
    func showCameraPermissions() {
        DispatchQueue.main.async { [weak self] in
            let popup = UIAlertController(title: "Error",
                                          message: "Please, grant access to camera",
                                          preferredStyle: .alert)
            self?.present(popup, animated: true)
        }
    }

    func showError(message: String, retry: @escaping () -> (), cancel: @escaping () -> ()) {
        DispatchQueue.main.async { [weak self] in
            guard let sSelf = self else { return }
            let popup = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            popup.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                cancel()
            }))
            popup.addAction(UIAlertAction(title: "Retry", style: .default, handler: { _ in
                retry()
            }))
            sSelf.present(popup, animated: true)
        }
    }

    func openTryon(with type: ViewType, session: WannaSDKSession, index: Int) {
        guard #available(iOS 13.0, *) else {
            presentAlert(title: "Not supported", message: "Too old iOS version")

            return
        }

        viewType = type
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(
            withIdentifier: type.rawValue
        ) as! TryOnViewController

        // Passing the session, storage, model list, and the index of the model the user has already selected
        // to the other view that will actually render the try-on
        controller.set(
            session: session,
            storage: storage!,
            renderModels: renderModels.map(\.renderModelID),
            selected: index
        )

        show(controller, sender: self)
    }
    
    func openTryon(session: WannaSDKSession, index: Int) {
        if let viewType = viewType {
            openTryon(with: viewType, session: session, index: index)
            return
        }

        let alert = UIAlertController(title: "Tryon",
                                      message: "Choose view type",
                                      preferredStyle: UIDevice.current.userInterfaceIdiom == .pad ? .alert : .actionSheet)
        alert.addAction(UIAlertAction(title: "Manual", style: .default) { _ in
            self.openTryon(with: ViewType.manual, session: session, index: index)
        })
        alert.addAction(UIAlertAction(title: "Xib", style: .default) { _ in
            self.openTryon(with: ViewType.xib, session: session, index: index)
        })
        present(alert, animated: true)
    }
}
