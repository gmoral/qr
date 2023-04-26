//
//  ApiClient.swift
//  ReadQR
//
//  Created by Guillermo Moral on 20/04/2023.
//

import Foundation

protocol ApiClientService {
    func request<T: Decodable>(url: URL?, type: T.Type) async throws -> T
}

