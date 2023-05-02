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

        let mapperAuthorizationResponse = CameraAuthorizationMapperData()
        let mapperAuthorizationStatusResponse = CameraAuthorizationStatusMapperData()
        let cameraService = CameraServiceImp()
        let cameraRepository = CameraRepositoryImp(cameraService: cameraService, mapperAuthorizationStatusResponse: mapperAuthorizationStatusResponse, mapperAuthorizationResponse: mapperAuthorizationResponse)
        let userPermissionUseCase = UserPermissionUseCaseImp(cameraRepository: cameraRepository)
        let deviceService = DeviceServiceImp()
        let deviceUseCase = DeviceUseCaseImp(deviceService: deviceService)
        let state = PassthroughSubject<ScannQRControllerStates, Never>()
        
        let scannQRViewModel = ScannQRViewModelImp(state: state, userPermissionUseCase: userPermissionUseCase, deviceUseCase: deviceUseCase)
        let scannQRViewController = ScannQRViewController(viewModel: scannQRViewModel, coordinator: coordinator)
        
        return scannQRViewController
    }
    
}
