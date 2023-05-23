//
//  TeamService.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 20.05.2023.
//

import Foundation

import Foundation

final class TeamService: TeamServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let requestFactory: URLRequestFactoryProtocol
    
    // MARK: - Lifecycle
    
    init(networkService: NetworkServiceProtocol, requestFactory: URLRequestFactoryProtocol) {
        self.networkService = networkService
        self.requestFactory = requestFactory
    }
    
    // MARK: - TeamServiceProtocol
    
    func createTeam(name: String, gameRoomId: String, token: String, completion: @escaping (Result<Team, Error>) -> Void) {
        do {
            let request = try requestFactory.createTeam(with: token, name: name, gameRoomId: gameRoomId)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func listTeamsForRoom(gameRoomId: String, token: String, completion: @escaping (Result<[Team], Error>) -> Void) {
        do {
            let request = try requestFactory.listTeams(for: gameRoomId, with: token)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func joinTeam(with teamId: String, token: String, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let request = try requestFactory.joinTeam(teamId: teamId, with: token)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}

