//
//  Coordinator.swift
//  QR
//
//  Created by Guillermo Moral on 26/04/2023.
//

import UIKit

protocol Coordinator {
    var navigation: UINavigationController { get }
    func start()
}
