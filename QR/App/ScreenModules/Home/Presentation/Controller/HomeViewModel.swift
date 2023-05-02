//
//  HomeViewModel.swift
//  QR
//
//  Created by Guillermo Moral on 26/04/2023.
//

import Combine
import Foundation

protocol HomeViewModel {
    var state: PassthroughSubject<HomeControllerStates, Never> { get }
    func viewDidLoad()
}

final class HomeViewModelImp: HomeViewModel {
    
    var state: PassthroughSubject<HomeControllerStates, Never>
    let userPermissionUseCase: UserPermissionUseCase
    
    // MARK: CONSTRUCTOR
    
    init(state: PassthroughSubject<HomeControllerStates, Never>, userPermissionUseCase: UserPermissionUseCase) {
        self.state = state
        self.userPermissionUseCase = userPermissionUseCase
    }
    
    // MARK: CUSTOM
    
    func viewDidLoad() {
        state.send(.start)
    }
}
