//
//  HomeViewModel.swift
//  QR
//
//  Created by Guillermo Moral on 26/04/2023.
//

import Combine
import Foundation

protocol HomeViewModel {
    var state: PassthroughSubject<HomeStateController, Never> { get }
    func viewDidLoad()
}

final class HomeViewModelImp: HomeViewModel {
    
    var state: PassthroughSubject<HomeStateController, Never>
    let userPermissionUseCase: UserPermissionUseCase
    
    // MARK: CONSTRUCTOR
    
    init(state: PassthroughSubject<HomeStateController, Never>, userPermissionUseCase: UserPermissionUseCase) {
        self.state = state
        self.userPermissionUseCase = userPermissionUseCase
    }
    
    // MARK: CUSTOM
    
    func viewDidLoad() {
        state.send(.start)
    }
    
//    func requestCameraAccess() {
//        Task {
//            
//            let avAuthorizationStatus = await userPermissionUseCase.requestCameraAccess()
//            
//            switch avAuthorizationStatus {
//                case .notDetermined:
//                    state.send(.notDetermined)
//                case .restricted:
//                    state.send(.restricted)
//                case .denied:
//                    state.send(.denied)
//                case .authorized:
//                    state.send(.authorized)
//                @unknown default:
//                    state.send(.notDetermined)
//            }
//        }
//    }
}
