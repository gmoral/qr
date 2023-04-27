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
    func requestCameraAccess()  async -> AVAuthorizationStatus
}

struct UserPermissionUseCaseImp: UserPermissionUseCase {
    
    private let cameraService: CameraService
    
    init(cameraService: CameraService) {
        self.cameraService = cameraService
    }
    
    func requestCameraAccess()  async -> AVAuthorizationStatus {
        return await cameraService.requestAuthorization()
    }
}
