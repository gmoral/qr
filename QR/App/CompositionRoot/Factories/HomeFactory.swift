//
//  HomeFactory.swift
//  QR
//
//  Created by Guillermo Moral on 26/04/2023.
//

import UIKit
import Combine

protocol HomeFactory {
    func makeModule(coordinator: HomeViewControllerCoordinator) -> UIViewController
}

struct HomeFactoryImp: HomeFactory {
    
    func makeModule(coordinator: HomeViewControllerCoordinator) -> UIViewController {
        
        let state = PassthroughSubject<StateController, Never>()
        let homeViewModel = HomeViewModelImp(state: state)
        let homeViewController = HomeViewController(viewModel: homeViewModel, coordinator: coordinator)
        
        return homeViewController
    }
    
}
