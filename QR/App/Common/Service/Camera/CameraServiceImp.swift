//
//  CameraServiceImp.swift
//  ReadQR
//
//  Created by Guillermo Moral on 25/04/2023.
//

import Foundation
import AVFoundation
import UIKit

actor AuthorizationActor {
    private var status = AVAuthorizationStatus.denied
    
    func setStatus(newStatus: AVAuthorizationStatus) {
        status = newStatus
    }
    
    func getStatus()->AVAuthorizationStatus {
        return status
    }
}

struct CameraServiceImp: CameraService{
        
    var isAuthorized: AVAuthorizationStatus {
        get async {
            var status = AVCaptureDevice.authorizationStatus(for: .video)
            
            var  authorized = false
            
            if status == .notDetermined {
                authorized = await AVCaptureDevice.requestAccess(for: .video)
            } else {
                return status
            }
            
            if authorized {
                status = .authorized
            } else {
                status = .denied
            }
            
            return status
        }
    }

    func requestAuthorization() async -> AVAuthorizationStatus {
        return await isAuthorized
    }
    
}
