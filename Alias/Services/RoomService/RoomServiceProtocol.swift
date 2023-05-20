//
//  RoomServiceProtocol.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 20.05.2023.
//

import Foundation

protocol RoomServiceProtocol {
    func listAllRooms(token: String, completion: @escaping (Result<[Room], Error>) -> Void)
    
}
