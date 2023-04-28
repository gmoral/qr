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
}

final class ScannQRViewModelImp: ScannQRViewModel {
    
    var state: PassthroughSubject<ScannQRStateController, Never>
    let userPermissionUseCase: UserPermissionUseCase
    
    // MARK: CONSTRUCTOR
    
    init(state: PassthroughSubject<ScannQRStateController, Never>, userPermissionUseCase: UserPermissionUseCase) {
        self.state = state
        self.userPermissionUseCase = userPermissionUseCase
    }
    
    // MARK: CUSTOM
    
    func viewDidLoad() {
        state.send(.start)
    }
    
    func requestCameraAccess() {
        Task {
            
            let avAuthorizationStatus = await userPermissionUseCase.requestAuthorizationStatus()
            
            switch avAuthorizationStatus {
                case .notDetermined:
                    let authorization = await userPermissionUseCase.requestAuthorization()
                    switch authorization {
                        case .notDetermined:
                        state.send(.notDetermined)
                        case .restricted:
                        state.send(.restricted)
                        case .denied:
                        state.send(.end)
                       case .authorized:
                        state.send(.authorized)
                       @unknown default:
                        state.send(.notDetermined)
                    }
                case .restricted:
                    state.send(.restricted)
                case .denied:
                    state.send(.denied)
                case .authorized:
                    state.send(.authorized)
                @unknown default:
                    state.send(.notDetermined)
            }
        }
    }
}
