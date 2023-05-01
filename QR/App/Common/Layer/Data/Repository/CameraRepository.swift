//
//  CameraRepository.swift
//  QR
//
//  Created by Guillermo Moral on 01/05/2023.
//

import Foundation

protocol CameraRepository {
    func getAuthorizationStatus() async -> AuthorizationEntity
    func getAuthorization() async -> AuthorizationEntity
}
