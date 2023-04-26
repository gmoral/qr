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
}

final class HomeViewModelImp: HomeViewModel {
    
    var state: PassthroughSubject<StateController, Never>

    init(state: PassthroughSubject<StateController, Never>) {
        self.state = state
    }
    
    func viewDidLoad() {
        state.send(.success)
    }
}
