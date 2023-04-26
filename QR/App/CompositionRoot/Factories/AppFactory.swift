//
//  AppFactory.swift
//  QR
//
//  Created by Guillermo Moral on 26/04/2023.
//

import UIKit

protocol AppFactory {
    
    func makeHomeCoordinator(navigation: UINavigationController) -> Coordinator
    
}

struct AppFactoryImp: AppFactory {
    
    func makeHomeCoordinator(navigation: UINavigationController) -> Coordinator {
        
        let homeFactory = HomeFactoryImp()
        let homeCoordinator = HomeCoordinator(navigation: navigation, homeFactory: homeFactory)
        
        return homeCoordinator
    }
}
