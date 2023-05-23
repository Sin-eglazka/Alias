//
//  UserService.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 20.05.2023.
//

import Foundation

final class UserService: UserServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let requestFactory: URLRequestFactoryProtocol
    
    // MARK: - Lifecycle
    
    init(networkService: NetworkServiceProtocol, requestFactory: URLRequestFactoryProtocol) {
        self.networkService = networkService
        self.requestFactory = requestFactory
    }
    
    // MARK: - UserServiceProtocol
    
    func register(name: String, email: String, password: String, completion: @escaping (Result<RegisterResponse, Error>) -> Void) {
        do {
            let request = try requestFactory.registerUser(name: name, email: email, password: password)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        do {
            let request = try requestFactory.loginUser(email: email, password: password)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    func logout(token: String, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            let request = try requestFactory.logout(with: token)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
