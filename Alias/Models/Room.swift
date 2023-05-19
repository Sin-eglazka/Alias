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
