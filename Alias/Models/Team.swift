//
//  Team.swift
//  Alias
//
//  Created by Kate on 19.05.2023.
//

import Foundation

struct Team: Codable {
    let id: String
    let name: String
    let users: [TeamPlayer]
}

struct TeamPlayer: Codable {
    let id: String
    let name: String
}
