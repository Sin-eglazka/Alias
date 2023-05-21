//
//  UserServiceProtocol.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 20.05.2023.
//

import Foundation

protocol UserServiceProtocol {
    func register(name: String, email: String, password: String, completion: @escaping (Result<RegisterResponse, Error>) -> Void)
    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void)
    func logout(token: String, completion: @escaping (Result<Void, Error>) -> Void)
}
