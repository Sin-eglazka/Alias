//
//  GamePresenter.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 22.05.2023.
//

import Foundation

final class GamePresenter {
    
    weak var viewInput: GameViewInput?
    
    // MARK: - Private properties
    
    private let roomService: RoomServiceProtocol
    private let gameService: GameServiceProtocol
    private let teamService: TeamServiceProtocol
    
    private let token = (UserDefaults.standard.object(forKey: "bearer token") as? String)
    private let room: JoinRoomResponse
    
    // MARK: - Lifecycle
    
    init(room: JoinRoomResponse, roomService: RoomServiceProtocol, gameService: GameServiceProtocol, teamService: TeamServiceProtocol) {
        self.roomService = roomService
        self.gameService = gameService
        self.teamService = teamService
        self.room = room
    }
    
    private func loadTeams() {
        guard let token = token else {
            viewInput?.showAlert(title: "Server error", text: "broken auth")
            return
        }
        
        teamService.listTeamsForRoom(gameRoomId: room.id, token: token) { [weak self] result in
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
        guard let token = token else {
            viewInput?.showAlert(title: "Server error", text: "broken auth")
            return
        }
        
        gameService.startRound(inRoom: room.id, token: token) { [weak self] result in
            switch result {
            case let .success(round):
                self?.viewInput?.updateRound(state: "Round started at \(round.startTime)")
            case .failure:
                self?.viewInput?.showAlert(title: "Server error", text: "Couldn't start round")
            }
        }
    }
    
    func wantToPauseRound() {
        guard let token = token else {
            viewInput?.showAlert(title: "Server error", text: "broken auth")
            return
        }
        
        gameService.pauseRound(inRoom: room.id, token: token) { [weak self] result in
            switch result {
            case let .success(round):
                self?.viewInput?.updateRound(state: "Round was paused at \(round.endTime ?? "")")
            case .failure:
                self?.viewInput?.showAlert(title: "Server error", text: "Couldn't pause round")
            }
        }
    }
    
    func createTeam(with name: String) {
        guard let token = token else {
            viewInput?.showAlert(title: "Server error", text: "broken auth")
            return
        }
        
        teamService.createTeam(name: name, gameRoomId: room.id, token: token) { [weak self] result in
            switch result {
            case .success(_):
                self?.viewInput?.updateAfterAddingTeam()
            case .failure:
                self?.viewInput?.showAlert(title: "Server error", text: "Couldn't create team")
            }
        }
    }
    
    func changeSettings() {
        let settingsPresenter = SettingsPresenter(room: room, roomService: roomService)
        viewInput?.presentSettings(output: settingsPresenter)
    }
    
    func leaveRoom() {
        guard let token = token else {
            viewInput?.showAlert(title: "Server error", text: "broken auth")
            return
        }
        
        roomService.leaveRoom(gameRoomId: room.id, token: token) { [weak self] result in
            switch result {
            case .success:
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
