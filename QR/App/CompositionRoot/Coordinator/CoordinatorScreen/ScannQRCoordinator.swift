//
//  QRCoordinator.swift
//  QR
//
//  Created by Guillermo Moral on 27/04/2023.
//

import UIKit

final class ScannQRCoordinator: Coordinator {
    var navigation: UINavigationController
    private let scannQRFactory: ScannQRFactory
    
    init(navigation: UINavigationController, scannQRFactory: ScannQRFactory) {
        self.navigation = navigation
        self.scannQRFactory = scannQRFactory
    }
    
    func start() {
        let controller = scannQRFactory.makeModule(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension ScannQRCoordinator: ScannQRViewControllerCoordinator{
    func toDO() {
        print("toDO...")
    }
}
