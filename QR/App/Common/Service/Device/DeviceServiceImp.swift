//
//  DeviceServiceImp.swift
//  QR
//
//  Created by Guillermo Moral on 28/04/2023.
//

import Foundation
import UIKit

struct DeviceServiceImp: DeviceService {
    func openSettings() {
        if let urlObj = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(urlObj, options: [:], completionHandler: nil)
        }
    }
}
