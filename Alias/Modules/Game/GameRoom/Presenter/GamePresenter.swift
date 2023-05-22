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
    
    private let token = (UserDefaults.standard.object(forKey: "bearer token") as? String)
    private let roomId: String
    
    init(roomId: String, roomService: RoomServiceProtocol, gameService: GameServiceProtocol, teamService: TeamServiceProtocol) {
        self.roomService = roomService
        self.gameService = gameService
        self.teamService = teamService
        self.roomId = roomId
    }
    
    private func loadTeams() {
        guard let token = token else {
            viewInput?.showAlert(title: "Server error", text: "broken auth")
            return
        }
        
        teamService.listTeamsForRoom(gameRoomId: roomId, token: token) { [weak self] result in
            switch result {
            case let .success(teams):
                self?.viewInput?.showTeams(teams)
            case .failure:
                self?.viewInput?.showAlert(title: "Server error", text: "Couldn't load teams")
            }
        }
    }
}

extension GamePresenter: GameViewOutput {
    
    func viewIsReady() {
        loadTeams()
    }
    
    func wantToStartRound() {
        
    }
    
    func wantToPauseRound() {
        
    }
    
    func createTeam(with name: String) {
        guard let token = token else {
            viewInput?.showAlert(title: "Server error", text: "broken auth")
            return
        }
        
        teamService.createTeam(name: name, gameRoomId: roomId, token: token) { [weak self] result in
            switch result {
            case .success(_):
                self?.viewInput?.updateAfterAddingTeam()
            case .failure:
                self?.viewInput?.showAlert(title: "Server error", text: "Couldn't create team")
            }
        }
    }
    
    func changeSettings() {
        
    }
    
    func leaveRoom() {
        guard let token = token else {
            viewInput?.showAlert(title: "Server error", text: "broken auth")
            return
        }
        
        roomService.leaveRoom(gameRoomId: roomId, token: token) { [weak self] result in
            switch result {
            case .success(_):
                self?.viewInput?.leaveRoom()
            case .failure:
                self?.viewInput?.showAlert(title: "Server error", text: "Couldn't leave room")
            }
        }
    }
    
    func joinTeam() {
        
    }
    
    func refreshTeams() {
        loadTeams()
    }
}
