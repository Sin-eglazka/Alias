//
//  Constants.swift
//  Alias
//
//  Created by Kate on 19.05.2023.
//

import Foundation

enum Constants {
    static let baseUrl = "alias-swift-api.onrender.com"
    static let localBaseURL = "127.0.0.1"
}

enum Endpoints {
    static let login = "/users/login"
    static let register = "/users/register"
    static let profile = "/users/profile"
    static let logout = "/users/logout"
    
    static let listRooms = "/game-rooms/list-all"
    static let createRoom = "/game-rooms/create"
    static let joinRoom = "/game-rooms/join-room"
    static let leaveRoom = "/game-rooms/leave-room"
    static let listPlayersInRoom = "/game-rooms/list-members"
    static let changeSettings = "/game-rooms/change-setting"
    
    static let createTeam = "/teams/create-team"
    static let listTeamsInRoom = "/teams/list-teams"
    static let joinTeam = "/teams/join-team"
}
