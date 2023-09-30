//
//  SceneDelegate.swift
//  QR
//
//  Created by Guillermo Moral on 26/04/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: Coordinator!
    var appFactory: AppFactory!

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let navigation = UINavigationController()
        let appFactory = AppFactoryImp()
        
        self.window = UIWindow(windowScene: scene)

        if let window = self.window {
            AppDelegate.shared.add(window: window)
        }

        appCoordinator = AppCoordinator(
            navigation: navigation,
            appFactory: appFactory, window: window)
        appCoordinator.start()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }

}

