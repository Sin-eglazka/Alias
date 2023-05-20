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
    
    func joinRoom(gameRoomId: String, invitationCode: String, token: String, completion: @escaping (Result<Void, Error>) -> Void) {
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
}
