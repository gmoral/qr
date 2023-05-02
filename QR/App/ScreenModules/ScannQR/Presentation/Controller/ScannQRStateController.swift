//
//  QRStateController.swift
//  QR
//
//  Created by Guillermo Moral on 27/04/2023.
//

import Foundation

enum ScannQRControllerStates {
    case start
    case success
    case fail(error: String)
    case loading
    case authorized
    case denied
    case needChangeSettings
    case notDetermined
    case restricted
    case end
}
