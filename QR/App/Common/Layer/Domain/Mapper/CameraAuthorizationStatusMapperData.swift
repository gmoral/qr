//
//  File.swift
//  QR
//
//  Created by Guillermo Moral on 01/05/2023.
//

import Foundation
import AVFoundation
import UIKit

class CameraAuthorizationStatusMapperData: MapperBase<AuthorizationEntity, AVAuthorizationStatus> {

    override func mapToEntity(model: AVAuthorizationStatus) -> AuthorizationEntity {

        switch model {
            case .notDetermined:
                return AuthorizationEntity(status: .notDetermined)
            case .restricted:
                return AuthorizationEntity(status: .restricted)
            case .denied:
                return AuthorizationEntity(status: .needChangeSettings)
            case .authorized:
                return AuthorizationEntity(status: .authorized)
            @unknown default:
                return AuthorizationEntity(status: .notDetermined)
        }
    }

    override func mapToModel(entity: AuthorizationEntity) -> AVAuthorizationStatus {

        switch entity.status {
            case .notDetermined:
                return AVAuthorizationStatus.notDetermined
            case .restricted:
                return AVAuthorizationStatus.restricted
            case .denied:
                return AVAuthorizationStatus.denied
            case .authorized:
                return AVAuthorizationStatus.authorized
            case .needChangeSettings:
                return AVAuthorizationStatus.denied
        }
    }
}
