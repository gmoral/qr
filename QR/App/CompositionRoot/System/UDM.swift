//
//  UDM.swift
//
//
//  Created by Guillermo Moral on 12/05/2022.
//

import Foundation

protocol UDMProtocol {
    func setV(v: Any, k: String)
    func getV(k: String) -> Any?
    func setNilFor(k: String)
}

class UDM: UDMProtocol {
    let defaults = UserDefaults.standard

    func setV(v: Any, k: String) {
        defaults.set(v, forKey: k)
        defaults.synchronize()
    }

    func getV(k: String) -> Any? {
        if let value = defaults.value(forKey: k) {
            return value
        } else {
            return nil
        }
    }

    func setNilFor(k: String) {
        defaults.removeObject(forKey: k)
    }
}

public enum UserDefaultsKeys: String {
    case worldOrientationHelp
    case backWallHelp
    case leftCornerHelp
    case rightCornerHelp
    case topEdgeHelp
    case paintSceneHelp
}
