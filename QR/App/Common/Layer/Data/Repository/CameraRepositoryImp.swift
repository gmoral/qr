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
    private let mapperAuthorizationResponse: MapperBase<AuthorizationEntity, AVAuthorizationStatus>
    private let mapperAuthorizationStatusResponse: MapperBase<AuthorizationEntity, AVAuthorizationStatus>

    init(cameraService: CameraService, mapperAuthorizationResponse: MapperBase<AuthorizationEntity, AVAuthorizationStatus>, mapperAuthorizationStatusResponse: MapperBase<AuthorizationEntity, AVAuthorizationStatus>) {
        self.cameraService = cameraService
        self.mapperAuthorizationResponse = mapperAuthorizationResponse
        self.mapperAuthorizationStatusResponse = mapperAuthorizationStatusResponse

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
