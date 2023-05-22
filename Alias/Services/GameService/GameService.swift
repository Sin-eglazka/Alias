//
//  GameService.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 22.05.2023.
//

import Foundation

final class GameService: GameServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let requestFactory: URLRequestFactoryProtocol
    
    init(networkService: NetworkServiceProtocol, requestFactory: URLRequestFactoryProtocol) {
        self.networkService = networkService
        self.requestFactory = requestFactory
    }
    
    func startRound(inRoom gameRoomId: String, token: String, completion: @escaping (Result<GameRound, Error>) -> Void) {
        do {
            let request = try requestFactory.startRoundInRoom(for: gameRoomId, with: token)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func pauseRound(inRoom gameRoomId: String, token: String, completion: @escaping (Result<GameRound, Error>) -> Void) {
        do {
            let request = try requestFactory.pauseRoundInRoom(for: gameRoomId, with: token)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
