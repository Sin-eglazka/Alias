//
//  URLRequestFactory.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 19.05.2023.
//

import Foundation

protocol URLRequestFactoryProtocol {
    func registerUser(name: String, email: String, password: String) throws -> URLRequest
    func loginUser(email: String, password: String) throws -> URLRequest
    func logout(with token: String) throws -> URLRequest
    
    func listRooms(with token: String) throws -> URLRequest
    func createRoom(with token: String, name: String, isPrivate: Bool) throws -> URLRequest
    func joinRoom(with token: String, gameRoomId: String, invitationCode: String) throws -> URLRequest
    func leaveRoom(with token: String, gameRoomId: String) throws -> URLRequest
    
    func createTeam(with token: String, name: String, gameRoomId: String) throws -> URLRequest
    func listTeams(for room: String, with token: String) throws -> URLRequest
    func listPlayersInRoom(for room: String, with token: String) throws -> URLRequest
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
        if !bodyObject.isEmpty {
            request.httpBody = try JSONSerialization.data(withJSONObject: bodyObject)
        }
        return request
    }
    
    private func makeGetRequest(path: String, parametres: [String:String]) throws -> URLRequest {
        guard let url = url(with: path, parameters: parametres) else {
            throw HttpError.badURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    private func url(with path: String, parameters: [String: String]) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = host
        urlComponents.port = 8080
        urlComponents.path = path
        
        if !parameters.isEmpty {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        }
        
        print(urlComponents)
        
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
    
    func loginUser(email: String, password: String) throws -> URLRequest {
        let request = try makePostRequest(
            path: Endpoints.login,
            bodyObject: ["email": email, "password": password]
        )
        return request
    }
    
    func logout(with token: String) throws -> URLRequest {
        var request = try makePostRequest(
            path: Endpoints.logout,
            bodyObject: [:]
        )
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func listRooms(with token: String) throws -> URLRequest {
        var request = try makeGetRequest(path: Endpoints.listRooms, parametres: [:])
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func createRoom(with token: String, name: String, isPrivate: Bool) throws -> URLRequest {
        var request = try makePostRequest(
            path: Endpoints.createRoom,
            bodyObject: ["name": name, "isPrivate": isPrivate]
        )
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func joinRoom(with token: String, gameRoomId: String, invitationCode: String) throws -> URLRequest {
        var request = try makePostRequest(
            path: Endpoints.joinRoom,
            bodyObject: ["gameRoomId": gameRoomId, "invitationCode": invitationCode]
        )
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func leaveRoom(with token: String, gameRoomId: String) throws -> URLRequest {
        var request = try makeGetRequest(
            path: Endpoints.leaveRoom,
            parametres: ["gameRoomId": gameRoomId]
        )
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func createTeam(with token: String, name: String, gameRoomId: String) throws -> URLRequest {
        var request = try makePostRequest(
            path: Endpoints.createTeam,
            bodyObject: ["name": name, "gameRoomId": gameRoomId]
        )
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func listTeams(for room: String, with token: String) throws -> URLRequest {
        var request = try makeGetRequest(
            path: Endpoints.listTeamsInRoom,
            parametres: ["gameRoomId": room]
        )
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func listPlayersInRoom(for room: String, with token: String) throws -> URLRequest {
        var request = try makeGetRequest(
            path: Endpoints.listPlayersInRoom,
            parametres: ["gameRoomId": room]
        )
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}
