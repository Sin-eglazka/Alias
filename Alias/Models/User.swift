//
//  User.swift
//  Alias
//
//  Created by Kate on 19.05.2023.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let passwordHash: String
}
