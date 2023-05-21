//
//  LoginResponse.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 20.05.2023.
//

import Foundation

struct LoginResponse: Codable {
    let id: String
    let value: String
    let user: User
}

struct User: Codable {
    let id: String
}
