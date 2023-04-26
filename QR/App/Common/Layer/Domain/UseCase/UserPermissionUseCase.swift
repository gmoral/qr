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
        switch await cameraService.requestAuthorizationStatus() {
            
        case .notDetermined:
            return await cameraService.requestAccess()
        case .restricted:
            return .restricted
        case .denied:
            return .denied
        case .authorized:
            return .authorized
        @unknown default:
            return .notDetermined
        }
    }
}
