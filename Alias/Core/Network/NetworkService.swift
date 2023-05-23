//
//  NetworkService.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 19.05.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func sendRequest<T: Decodable>(_ request: URLRequest, completion: @escaping (Result<T, Error>) -> Void)
    func sendRequest(_ request: URLRequest, completion: @escaping (Result<Void, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func sendRequest<T: Decodable>(_ request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        session.dataTask(with: request) { data, response , error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(HttpError.badResponse))
                return
            }
            
            do {
                print(data)
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func sendRequest(_ request: URLRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        session.dataTask(with: request) { data, response , error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(HttpError.badResponse))
                return
            }
            
            if httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 {
                completion(.success(()))
            } else {
                completion(.failure(HttpError.badResponse))
            }
        }.resume()
    }
}
