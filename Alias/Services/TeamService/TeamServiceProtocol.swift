//
//  TeamServiceProtocol.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 20.05.2023.
//

import Foundation

protocol TeamServiceProtocol {
    func createTeam(name: String, gameRoomId: String, token: String, completion: @escaping (Result<Team, Error>) -> Void)
    func listTeamsForRoom(gameRoomId: String, token: String, completion: @escaping (Result<[Team], Error>) -> Void)
    func joinTeam(with teamId: String, token: String, completion: @escaping (Result<Void, Error>) -> Void)
}
