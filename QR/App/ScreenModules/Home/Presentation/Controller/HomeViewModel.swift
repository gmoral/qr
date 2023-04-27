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
}
