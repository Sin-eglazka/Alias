//
//  URLRequestFactoryProtocol.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 20.05.2023.
//

import Foundation

protocol URLRequestFactoryProtocol {
    func registerUser(name: String, email: String, password: String) throws -> URLRequest
    func loginUser(email: String, password: String) throws -> URLRequest
    func logout(with token: String) throws -> URLRequest
    
    func listRooms(with token: String) throws -> URLRequest
    func createRoom(with token: String, name: String, isPrivate: Bool) throws -> URLRequest
    func joinRoom(with token: String, gameRoomId: String, invitationCode: String?) throws -> URLRequest
    func leaveRoom(with token: String, gameRoomId: String) throws -> URLRequest
    func changeSettingsInRoom(for room: String, points: Int, isPrivate: Bool, name: String, with token: String) throws -> URLRequest
    
    func createTeam(with token: String, name: String, gameRoomId: String) throws -> URLRequest
    func listTeams(for room: String, with token: String) throws -> URLRequest
    func listPlayersInRoom(for room: String, with token: String) throws -> URLRequest
    func joinTeam(teamId: String, with token: String) throws -> URLRequest
}
