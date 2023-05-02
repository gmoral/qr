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
    func scannQR() -> ScannQRManager
}

final class ScannQRViewModelImp: ScannQRViewModel, ScannQRManagerDelegate {
    
    var state: PassthroughSubject<ScannQRStateController, Never>
    let userPermissionUseCase: UserPermissionUseCase
    let deviceUseCase: DeviceUseCase
    public let scannQRManager: ScannQRManager
    
    // MARK: CONSTRUCTOR
    
    init(state: PassthroughSubject<ScannQRStateController, Never>, userPermissionUseCase: UserPermissionUseCase, deviceUseCase: DeviceUseCase, scannQRManager: ScannQRManager) {
        self.state = state
        self.userPermissionUseCase = userPermissionUseCase
        self.deviceUseCase = deviceUseCase
        self.scannQRManager = scannQRManager
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
    
    // MARK: CUSTOM
    
    func failed() {
        //TDOD
        print("Fail")
    }
    
    func found(code: String) {
        //TDOD
        print(">> Found <<")
    }
    
    func scannQR() -> ScannQRManager {
        return scannQRManager
    }
}
