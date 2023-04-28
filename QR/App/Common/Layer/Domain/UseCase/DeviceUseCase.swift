//
//  DeviceUseCase.swift
//  QR
//
//  Created by Guillermo Moral on 28/04/2023.
//

import Foundation

protocol DeviceUseCase {
    func requestOpenSettings()
}

struct DeviceUseCaseImp: DeviceUseCase {
    
    private let deviceService: DeviceService
    
    init(deviceService: DeviceService) {
        self.deviceService = deviceService
    }
    
    func requestOpenSettings() {
        deviceService.openSettings()
    }
}
