//
//  HomeFactory.swift
//  QR
//
//  Created by Guillermo Moral on 26/04/2023.
//

import UIKit
import Combine

protocol HomeFactory {
    
    func makeModule(coordinator: HomeViewControllerCoordinator) -> UIViewController
    func makeCoordinatorScannQR(navigation: UINavigationController) -> Coordinator
}

struct HomeFactoryImp: HomeFactory {
    
    func makeModule(coordinator: HomeViewControllerCoordinator) -> UIViewController {
        let cameraService = CameraServiceImp()
        let userPermissionUseCase = UserPermissionUseCaseImp(cameraService: cameraService)
        let state = PassthroughSubject<HomeStateController, Never>()
        
        let homeViewModel = HomeViewModelImp(state: state, userPermissionUseCase: userPermissionUseCase)
        let homeViewController = HomeViewController(viewModel: homeViewModel, coordinator: coordinator)
        
        return homeViewController
    }

    func makeCoordinatorScannQR(navigation: UINavigationController) -> Coordinator {
        let scannQRFactory = ScannQRFactoryImp()
        let scannQRCoordinator = ScannQRCoordinator(navigation: navigation, scannQRFactory: scannQRFactory)
        return scannQRCoordinator
    }
}
