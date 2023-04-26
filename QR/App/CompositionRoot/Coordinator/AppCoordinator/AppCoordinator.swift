//
//  AppCoordinator.swift
//  QR
//
//  Created by Guillermo Moral on 26/04/2023.
//

import Foundation
import UIKit

final class AppCoordinator : Coordinator {
    
    var navigation: UINavigationController
    private let appFactory: AppFactory
    private var homeCoordinator: Coordinator?
    
    init(navigation: UINavigationController, appFactory: AppFactory, window: UIWindow?) {
        
        self.navigation = navigation
        self.appFactory = appFactory
        
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        configWindow(window: window)
    }
    
    func start() {
        homeCoordinator = appFactory.makeHomeCoordinator(navigation: self.navigation)
        homeCoordinator?.start()
    }
    
    private func configWindow(window: UIWindow?) {
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}
