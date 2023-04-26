//
//  CameraServiceImp.swift
//  ReadQR
//
//  Created by Guillermo Moral on 25/04/2023.
//

import Foundation
import AVFoundation
import UIKit

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
        
        var status = AVAuthorizationStatus.denied
        
//        DispatchQueue.main.async {
//            AVCaptureDevice.requestAccess(for: .video) { granted in
//                if granted {
//                    
//                    // status = AVAuthorizationStatus.authorized
//                }
//            }
//        }
        return status
    }
}
