//
//  NetworkServiceProtocol.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 24.05.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func sendRequest<T: Decodable>(_ request: URLRequest, completion: @escaping (Result<T, Error>) -> Void)
    func sendRequest(_ request: URLRequest, completion: @escaping (Result<Void, Error>) -> Void)
}
