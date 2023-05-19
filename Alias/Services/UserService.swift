//
//  UserService.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 20.05.2023.
//

import Foundation

final class UserService {
    
    private let networkService: NetworkServiceProtocol
    private let requestFactory: URLRequestFactoryProtocol
    
    init(networkService: NetworkServiceProtocol, requestFactory: URLRequestFactoryProtocol) {
        self.networkService = networkService
        self.requestFactory = requestFactory
    }
    
    func register(name: String, email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        do {
            let request = try requestFactory.registerUser(name: name, email: email, password: password)
            networkService.sendRequest(request, completion: completion)
        } catch {
            completion(.failure(error))
        }
    }
}
