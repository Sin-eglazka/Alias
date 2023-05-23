//
//  RoomService.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 20.05.2023.
//

import Foundation

final class RoomService: RoomServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let requestFactory: URLRequestFactoryProtocol
    
    init(networkService: NetworkServiceProtocol, requestFactory: URLRequestFactoryProtocol) {
        self.networkService = networkService
        self.requestFactory = requestFactory
    }
    
    func listAllRooms(token: String, completion: @escaping (Result<[Room], Error>) -> Void) {
        do {
            let request = try requestFactory.listRooms(with: token)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func createRoom(name: String, isPrivate: Bool, token: String, completion: @escaping (Result<GameRoom, Error>) -> Void) {
        do {
            let request = try requestFactory.createRoom(with: token, name: name, isPrivate: isPrivate)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func joinRoom(gameRoomId: String, invitationCode: String?, token: String, completion: @escaping (Result<JoinRoomResponse, Error>) -> Void) {
        do {
            let request = try requestFactory.joinRoom(with: token, gameRoomId: gameRoomId, invitationCode: invitationCode)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func leaveRoom(gameRoomId: String, token: String, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let request = try requestFactory.leaveRoom(with: token, gameRoomId: gameRoomId)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func listPlayersInRoom(gameRoomId: String, token: String, completion: @escaping (Result<[TeamPlayer], Error>) -> Void) {
        do {
             let request = try requestFactory.listPlayersInRoom(for: gameRoomId, with: token)
             networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func changeSettingsInRoom(for room: String, points: Int, isPrivate: Bool, name: String, with token: String, completion: @escaping (Result<Room, Error>) -> Void) {
        do {
             let request = try requestFactory.changeSettingsInRoom(for: room, points: points, isPrivate: isPrivate, name: name, with: token)
             networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
