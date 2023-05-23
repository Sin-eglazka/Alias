//
//  URLRequestFactory.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 19.05.2023.
//

import Foundation

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
        urlComponents.scheme = "https"
        urlComponents.host = host
        //urlComponents.port = 8080
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
    
    // MARK: - UserService requests
    
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
    
    // MARK: - RoomService requests
    
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
    
    func joinRoom(with token: String, gameRoomId: String, invitationCode: String?) throws -> URLRequest {
        var body: [String : String]
        if let invitationCode = invitationCode {
            body = ["gameRoomId": gameRoomId, "invitationCode": invitationCode]
        } else {
            body = ["gameRoomId": gameRoomId]
        }
        var request = try makePostRequest(
            path: Endpoints.joinRoom,
            bodyObject: body
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
    
    func listPlayersInRoom(for room: String, with token: String) throws -> URLRequest {
        var request = try makeGetRequest(
            path: Endpoints.listPlayersInRoom,
            parametres: ["gameRoomId": room]
        )
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func changeSettingsInRoom(for room: String, points: Int, isPrivate: Bool, name: String, with token: String) throws -> URLRequest {
        var request = try makePostRequest(
            path: Endpoints.changeSettings,
            bodyObject: ["isPrivate": isPrivate, "gameRoomId": room, "points": points, "name": name]
        )
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    // MARK: - TeamService requests
    
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
    
    func joinTeam(teamId: String, with token: String) throws -> URLRequest {
        var request = try makePostRequest(
            path: Endpoints.joinTeam,
            bodyObject: ["teamId": teamId]
        )
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    // MARK: - GameService requests
    
    func startRoundInRoom(for roomId: String, with token: String) throws -> URLRequest {
        var request = try makePostRequest(
            path: Endpoints.startGameRound,
            bodyObject: ["gameRoomId": roomId]
        )
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func pauseRoundInRoom(for roomId: String, with token: String) throws -> URLRequest {
        var request = try makePostRequest(
            path: Endpoints.pauseGameRound,
            bodyObject: ["gameRoomId": roomId]
        )
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
}
