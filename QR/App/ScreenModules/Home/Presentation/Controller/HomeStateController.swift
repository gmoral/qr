//
//  State.swift
//  ReadQR
//
//  Created by Guillermo Moral on 20/04/2023.
//

enum HomeStateController {
    case start
    case success
    case fail(error: String)
    case loading
    case authorized
    case denied
    case notDetermined
    case restricted
    case end
}
