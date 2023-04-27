//
//  HomeCoordinator.swift
//  QR
//
//  Created by Guillermo Moral on 26/04/2023.
//

import UIKit

final class HomeCoordinator: Coordinator {
    var navigation: UINavigationController
    private let homeFactory : HomeFactory
    
    init(navigation: UINavigationController, homeFactory: HomeFactory) {
        self.navigation = navigation
        self.homeFactory = homeFactory
    }
    
    func start() {
        let controller = homeFactory.makeModule(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension HomeCoordinator : HomeViewControllerCoordinator {
    
    func redirectScannQR() {
        let coordinator = homeFactory.makeCoordinatorScannQR(
            navigation: navigation)
        coordinator.start()
    }
}
