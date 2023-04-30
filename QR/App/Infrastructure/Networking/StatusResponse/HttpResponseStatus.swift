//
//  HttpResponseStatus.swift
//  ReadQR
//
//  Created by Guillermo Moral on 20/04/2023.
//

import Foundation

enum HttpResponseStatus {
    static let information = 100...199
    static let success = 200...299
    static let redirect = 300...399
    static let clientError = 400...499
    static let serverError = 500...599
}
