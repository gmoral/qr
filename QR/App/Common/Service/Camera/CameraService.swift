//
//  CameraService.swift
//  ReadQR
//
//  Created by Guillermo Moral on 25/04/2023.
//

import Foundation
import AVFoundation
import UIKit

protocol CameraService {
    func requestAuthorization() async -> AVAuthorizationStatus
    func requestAuthorizationStatus() async -> AVAuthorizationStatus
}
