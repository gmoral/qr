//
//  CameraRepositoryImp.swift
//  QR
//
//  Created by Guillermo Moral on 01/05/2023.
//

import Foundation
import AVFoundation
import UIKit

struct CameraRepositoryImp: CameraRepository {

    private let cameraService: CameraService
    private let mapperAuthorizationStatusResponse: MapperBase<AuthorizationEntity, AVAuthorizationStatus>
    private let mapperAuthorizationResponse: MapperBase<AuthorizationEntity, AVAuthorizationStatus>

    init(cameraService: CameraService, mapperAuthorizationStatusResponse: MapperBase<AuthorizationEntity, AVAuthorizationStatus>, mapperAuthorizationResponse: MapperBase<AuthorizationEntity, AVAuthorizationStatus>) {
        self.cameraService = cameraService
        self.mapperAuthorizationStatusResponse = mapperAuthorizationStatusResponse
        self.mapperAuthorizationResponse = mapperAuthorizationResponse
    }

    func getAuthorizationStatus() async -> AuthorizationEntity {

        let status = await cameraService.requestAuthorizationStatus()
        return mapperAuthorizationStatusResponse.mapToEntity(model: status)
    }

    func getAuthorization() async -> AuthorizationEntity {

        let status = await cameraService.requestAuthorization()
        return mapperAuthorizationResponse.mapToEntity(model: status)
    }
}
