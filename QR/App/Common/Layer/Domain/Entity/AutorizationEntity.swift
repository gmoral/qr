//
//  AutorizationEntity.swift
//  QR
//
//  Created by Guillermo Moral on 01/05/2023.
//

import Foundation

public enum AuthorizationStatus : Int {

    case notDetermined = 0

    case restricted = 1

    case denied = 2

    case authorized = 3

    case needChangeSettings = 4
}

struct AuthorizationEntity {
    public var status : AuthorizationStatus

    public init(status: AuthorizationStatus) {
        self.status = status
    }
}
