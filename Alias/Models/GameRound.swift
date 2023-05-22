//
//  GameRound.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 22.05.2023.
//

import Foundation

struct GameRound: Codable {
    let id: String
    let gameRoom: GameForRound
    let startTime: String
    let endTime: String?
    let state: String
}

struct GameForRound: Codable {
    let id: String
}
