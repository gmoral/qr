//
//  State.swift
//  ReadQR
//
//  Created by Guillermo Moral on 20/04/2023.
//

enum StateController {
    case success
    case loading
    case authorized
    case denied
    case notDetermined
    case restricted
    case fail(error: String)
}


