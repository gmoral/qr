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
    
    func requestAuthorizationStatus() async -> AVAuthorizationStatus {
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .notDetermined:
                return .notDetermined
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
    
    func requestAccess() async -> AVAuthorizationStatus {
        let authorizationActor = AuthorizationActor()
        
        AVCaptureDevice.requestAccess(for: .video) { granted in
            if granted {
                Task {
                    await authorizationActor .setStatus(newStatus: .authorized)
                }
            }
        }
        
        return await authorizationActor.getStatus()
    }
}
