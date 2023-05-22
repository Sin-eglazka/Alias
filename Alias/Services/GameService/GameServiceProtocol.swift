//
//  GameServiceProtocol.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 22.05.2023.
//

import Foundation

protocol GameServiceProtocol {
    func startRound(inRoom gameRoomId: String, token: String, completion: @escaping (Result<GameRound, Error>) -> Void)
    func pauseRound(inRoom gameRoomId: String, token: String, completion: @escaping (Result<GameRound, Error>) -> Void)
}
