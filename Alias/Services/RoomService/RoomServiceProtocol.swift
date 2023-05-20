//
//  RoomServiceProtocol.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 20.05.2023.
//

import Foundation

protocol RoomServiceProtocol {
    func listAllRooms(token: String, completion: @escaping (Result<[Room], Error>) -> Void)
    func createRoom(name: String, isPrivate: Bool, token: String, completion: @escaping (Result<GameRoom, Error>) -> Void)
    func joinRoom(gameRoomId: String, invitationCode: String, token: String, completion: @escaping (Result<Void, Error>) -> Void)
    func leaveRoom(gameRoomId: String, token: String, completion: @escaping (Result<Void, Error>) -> Void)
}
