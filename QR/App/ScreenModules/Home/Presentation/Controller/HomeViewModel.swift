//
//  HomeViewModel.swift
//  QR
//
//  Created by Guillermo Moral on 26/04/2023.
//

import Combine
import Foundation

protocol HomeViewModel {
    var state: PassthroughSubject<StateController, Never> { get }
    func viewDidLoad()
    func requestCameraAccess()
}

final class HomeViewModelImp: HomeViewModel {
    
    let userPermissionUseCase: UserPermissionUseCase
    var state: PassthroughSubject<StateController, Never>
    
    init(state: PassthroughSubject<StateController, Never>, userPermissionUseCase: UserPermissionUseCase) {
        self.state = state
        self.userPermissionUseCase = userPermissionUseCase
    }
    
    func viewDidLoad() {
        state.send(.success)
    }
    
    func requestCameraAccess() {
        Task {
            
            let avAuthorizationStatus = await userPermissionUseCase.requestCameraAccess()
            
            switch avAuthorizationStatus {
                case .notDetermined:
                    state.send(.notDetermined)
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
