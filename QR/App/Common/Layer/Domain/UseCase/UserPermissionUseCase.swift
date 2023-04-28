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
    func requestAuthorization()  async -> AVAuthorizationStatus
    func requestAuthorizationStatus()  async -> AVAuthorizationStatus
}

struct UserPermissionUseCaseImp: UserPermissionUseCase {
    
    private let cameraService: CameraService
    
    init(cameraService: CameraService) {
        self.cameraService = cameraService
    }
    
    func requestAuthorization()  async -> AVAuthorizationStatus {
        return await cameraService.requestAuthorization()
    }
    
    func requestAuthorizationStatus()  async -> AVAuthorizationStatus {
        return await cameraService.requestAuthorizationStatus()
    }
}
