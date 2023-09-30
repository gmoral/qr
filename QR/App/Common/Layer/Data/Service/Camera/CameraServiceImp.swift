//
//  CameraServiceImp.swift
//  ReadQR
//
//  Created by Guillermo Moral on 25/04/2023.
//

import Foundation
import AVFoundation
import UIKit

struct CameraServiceImp: CameraService {
        
    var isAuthorized: AVAuthorizationStatus {
        get async {
            var status = AVAuthorizationStatus.denied
            
            var  authorized = false
            
            authorized = await AVCaptureDevice.requestAccess(for: .video)
            
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
    
    func requestAuthorizationStatus() async -> AVAuthorizationStatus {
        return AVCaptureDevice.authorizationStatus(for: .video)
    }
}
