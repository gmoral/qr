//
//  ApiClientServiceImp.swift
//  ReadQR
//
//  Created by Guillermo Moral on 20/04/2023.
//

import Foundation

struct ApiClientServiceImp: ApiClientService {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Decodable>(url: URL?, type: T.Type) async throws -> T {
        guard let url = url else { throw ApiError.errorInUrl }
        
        return try await makeRequest(url: url)
    }
    
    private func makeRequest<T: Decodable>(url: URL) async throws -> T {
        let request = try await session.data(from: url)
        return try validateResponse(request: request)
    }
    
    private func validateResponse <T: Decodable>(
        request: (data: Data, httpResponse: URLResponse)
    ) throws -> T {
        guard let httpResponse = request.httpResponse as? HTTPURLResponse
        else { throw ApiError.unknownError }
        switch httpResponse.statusCode {
        case HttpResponseStatus.information:
            throw ApiError.unknownError
        case HttpResponseStatus.success:
            return try decoModel(data: request.data)
        case HttpResponseStatus.redirect:
            throw ApiError.unknownError
        case HttpResponseStatus.clientError:
            throw ApiError.clientError
        case HttpResponseStatus.serverError:
            throw ApiError.serverError
        default:
            throw ApiError.unknownError
        }
    }
    
    private func decoModel<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        let model = try? decoder.decode(T.self, from: data)
        guard let model = model else { throw ApiError.errorDecoding }
        return model
    }
    
}
