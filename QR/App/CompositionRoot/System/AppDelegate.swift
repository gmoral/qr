//
//  AppDelegate.swift
//  QR
//
//  Created by Guillermo Moral on 26/04/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    weak var appWindow: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
}

extension AppDelegate {

    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    var rootViewController: UIViewController {

        return AppDelegate.shared.appWindow?.rootViewController as! UIViewController
    }

    func add(window: UIWindow) {
        self.appWindow = window
    }
}
