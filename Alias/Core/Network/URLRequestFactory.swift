//
//  URLRequestFactory.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 19.05.2023.
//

import Foundation

protocol URLRequestFactoryProtocol {
    func registerUser(name: String, email: String, password: String) throws -> URLRequest
    
}

final class URLRequestFactory {
    
    private let host: String
    
    init(host: String) {
        self.host = host
    }
    
    private func makePostRequest(path: String, bodyObject: [String: Codable]) throws -> URLRequest {
        guard let url = url(with: path, parameters: [:]) else {
            throw HttpError.badURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: bodyObject)
        return request
    }
    
    private func url(with path: String, parameters: [String: String]) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        guard let url = urlComponents.url else {
            return nil
        }
        return url
    }
    
}

extension URLRequestFactory: URLRequestFactoryProtocol {
    
    func registerUser(name: String, email: String, password: String) throws -> URLRequest {
        let request = try makePostRequest(
            path: Endpoints.register,
            bodyObject: ["name": name, "email": email, "password": password]
        )
        return request
    }
}
