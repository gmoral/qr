//
//  QRViewModel.swift
//  QR
//
//  Created by Guillermo Moral on 27/04/2023.
//

import Combine
import Foundation

protocol ScannQRViewModel {
    var state: PassthroughSubject<ScannQRStateController, Never> { get }
    func viewDidLoad()
    func requestCameraAccess()
    func openSettings()
}

final class ScannQRViewModelImp: ScannQRViewModel {
    
    var state: PassthroughSubject<ScannQRStateController, Never>
    let userPermissionUseCase: UserPermissionUseCase
    let deviceUseCase: DeviceUseCase
    
    // MARK: CONSTRUCTOR
    
    init(state: PassthroughSubject<ScannQRStateController, Never>, userPermissionUseCase: UserPermissionUseCase, deviceUseCase: DeviceUseCase) {
        self.state = state
        self.userPermissionUseCase = userPermissionUseCase
        self.deviceUseCase = deviceUseCase
    }
    
    // MARK: CUSTOM
    
    func viewDidLoad() {
        state.send(.start)
    }
    
    func requestCameraAccess() {
        Task {
            let authorizationEntity = await userPermissionUseCase.requestAuthorizationStatus()
            processAutorizationStatus(authorizationEntity: authorizationEntity)
        }
    }

    func processAutorizationStatus(authorizationEntity: AuthorizationEntity) {

        switch authorizationEntity.status {

        case .notDetermined:
            Task {
                let authorizationEntity = await userPermissionUseCase.requestAuthorization()
                processAutorizationStatus(authorizationEntity: authorizationEntity)
            }
        case .restricted:
            state.send(.restricted)
        case .denied:
            state.send(.denied)
        case .authorized:
            state.send(.authorized)
        case .needChangeSettings:
            state.send(.needChangeSettings)
        }
    }
    
    func openSettings() {
        deviceUseCase.requestOpenSettings()
    }
}
