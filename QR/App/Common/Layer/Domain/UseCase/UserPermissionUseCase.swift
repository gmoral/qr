//
//  UserPermissionUseCase.swift
//  ReadQR
//
//  Created by Guillermo Moral on 25/04/2023.
//

import Foundation
import AVFoundation
import UIKit

protocol UserPermissionUseCase {
    func requestAuthorization()  async -> AuthorizationEntity
    func requestAuthorizationStatus()  async -> AuthorizationEntity
}

struct UserPermissionUseCaseImp: UserPermissionUseCase {
    
    private let cameraRepository: CameraRepository
    
    init(cameraRepository: CameraRepository) {
        self.cameraRepository = cameraRepository
    }
    
    func requestAuthorization()  async -> AuthorizationEntity {
        return await cameraRepository.getAuthorization()
    }
    
    func requestAuthorizationStatus()  async -> AuthorizationEntity {
        return await cameraRepository.getAuthorizationStatus()
    }
}
