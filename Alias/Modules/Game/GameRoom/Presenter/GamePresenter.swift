//
//  GamePresenter.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 22.05.2023.
//

import Foundation

final class GamePresenter {
    
    weak var viewInput: GameViewInput?
    
    private let roomService: RoomServiceProtocol
    private let gameService: GameServiceProtocol
    private let teamService: TeamServiceProtocol
    
    init(roomService: RoomServiceProtocol, gameService: GameServiceProtocol, teamService: TeamServiceProtocol) {
        self.roomService = roomService
        self.gameService = gameService
        self.teamService = teamService
    }
    
}

extension GamePresenter: GameViewOutput {
    
    func viewIsReady() {
        
    }
    
    func wantToStartRound() {
        
    }
    
    func wantToPauseRound() {
        
    }
    
    func createTeam(with name: String) {
        
    }
    
    func changeSettings() {
        
    }
    
    func leaveRoom() {
        
    }
    
    func joinTeam() {
        
    }
    
    
}
