//
//  Room.swift
//  Alias
//
//  Created by Kate on 19.05.2023.
//

import Foundation

struct Room: Codable {
    let isPrivate: Bool
    let id: String
    let admin: String
    let name: String
    let creator: String
    let invitationCode: String?
}

struct GameRoom: Codable {
    let isPrivate: Bool
    let id: String
    let admin: User
    let name: String
    let creator: User
    let invitationCode: String?
    let pointsPerWord: Int
}

struct JoinRoomResponse: Codable {
    let isPrivate: Bool
    let id: String
    let admin: String
    let name: String
    let creator: String
    let invitationCode: String?
    let points: Int
}

