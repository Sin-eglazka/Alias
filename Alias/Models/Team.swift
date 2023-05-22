//
//  Team.swift
//  Alias
//
//  Created by Kate on 19.05.2023.
//

import Foundation

struct Team: Codable {
    internal init(id: String, name: String, users: [TeamPlayer]) {
        self.id = id
        self.name = name
        self.users = users
    }
    
    let id: String
    let name: String
    let users: [TeamPlayer]
}

struct TeamPlayer: Codable {
    internal init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    let id: String
    let name: String
}
