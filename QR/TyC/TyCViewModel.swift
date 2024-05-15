//
//  TyCViewModel.swift
//  
//
//  Created by Guillermo Moral on 27/09/2023.
//

import Combine

protocol TyCViewModel {
    var state: PassthroughSubject<TyCStateController, Never> { get }
    func viewDidLoad()
    func aceptTermsAndConditions()
    func cancelTermsAndConditions()
}

final class TyCViewModelImp : TyCViewModel {

    var state: PassthroughSubject<TyCStateController, Never>

    init(state: PassthroughSubject<TyCStateController, Never>) {
        self.state = state
    }

    func viewDidLoad() {
        print("")
        state.send(.start)
        print("")
    }

    func aceptTermsAndConditions() {
        //TODO:
    }

    func cancelTermsAndConditions() {
        state.send(.end)
    }
}
