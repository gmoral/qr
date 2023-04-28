//
//  QRFactory.swift
//  QR
//
//  Created by Guillermo Moral on 27/04/2023.
//

import UIKit
import Combine

protocol ScannQRFactory {
    func makeModule(coordinator: ScannQRViewControllerCoordinator) -> UIViewController
}

struct ScannQRFactoryImp: ScannQRFactory {
    
    func makeModule(coordinator: ScannQRViewControllerCoordinator) -> UIViewController {
        
        let cameraService = CameraServiceImp()
        let userPermissionUseCase = UserPermissionUseCaseImp(cameraService: cameraService)
        let deviceService = DeviceServiceImp()
        let deviceUseCase = DeviceUseCaseImp(deviceService: deviceService)
        let state = PassthroughSubject<ScannQRStateController, Never>()
        
        let scannQRViewModel = ScannQRViewModelImp(state: state, userPermissionUseCase: userPermissionUseCase, deviceUseCase: deviceUseCase)
        let scannQRViewController = ScannQRViewController(viewModel: scannQRViewModel, coordinator: coordinator)
        
        return scannQRViewController
    }
    
}
