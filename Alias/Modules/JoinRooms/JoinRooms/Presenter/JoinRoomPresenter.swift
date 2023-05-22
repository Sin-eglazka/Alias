//
//  JoinRoomPresenter.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 21.05.2023.
//

import Foundation

final class JoinRoomPresenter {
    
    weak var viewInput: JoinRoomViewInput?
    
    private let roomService: RoomServiceProtocol
    private let userService: UserServiceProtocol
    
    init(roomService: RoomServiceProtocol, userService: UserServiceProtocol) {
        self.roomService = roomService
        self.userService = userService
    }
    
    private func loadRooms() {
        guard let token = (UserDefaults.standard.object(forKey: "bearer token") as? String) else {
            viewInput?.showAlert(title: "Server error", text: "broken auth")
            return
        }
        
        roomService.listAllRooms(token: token) { [weak self] result in
            switch result {
            case let .success(rooms):
                self?.viewInput?.showRooms(rooms)
            case .failure:
                self?.viewInput?.showAlert(title: "Server error", text: "Couldn't load rooms")
            }
        }
    }
}

extension JoinRoomPresenter: JoinRoomViewOutput {
    
    func viewIsReady() {
        loadRooms()
    }
    
    func refreshRooms() {
        loadRooms()
    }
    
    func wantToLogout() {
        guard let token = (UserDefaults.standard.object(forKey: "bearer token") as? String) else {
            viewInput?.showAlert(title: "Server error", text: "broken auth")
            return
        }
        
        userService.logout(token: token) { [weak self] result in
            switch result {
            case .success(()):
                DispatchQueue.main.async {
                    UserDefaults.standard.removeObject(forKey: "bearer token")
                    self?.viewInput?.logoutSuccess()
                }
            case .failure:
                self?.viewInput?.showAlert(title: "Server error", text: "Couldn't logout")
            }
        }
    }
    
    func joinRoom(roomId: String, name: String, invitationCode: String? ,isAdmin: Bool) {
        guard let token = (UserDefaults.standard.object(forKey: "bearer token") as? String) else {
            viewInput?.showAlert(title: "Server error", text: "broken auth")
            return
        }
        
        roomService.joinRoom(gameRoomId: roomId, invitationCode: invitationCode, token: token) { [weak self] result in
            switch result {
            case .success(()):
                DispatchQueue.main.async {
                    let assembly = ServiceAssembly()
                    guard let roomService = self?.roomService else { return }
                    let presenter = GamePresenter(
                        roomId: roomId,
                        roomService: roomService,
                        gameService: assembly.makeGameService(),
                        teamService: assembly.makeTeamService()
                    )
                    let gameRoomVC = GameViewController(roomId: roomId, name: name, isAdmin: isAdmin, output: presenter)
                    presenter.viewInput = gameRoomVC
                    self?.viewInput?.presentRoom(vc: gameRoomVC)
                }
            case .failure:
                self?.viewInput?.showAlert(title: "Server error", text: "Couldn't join room")
            }
        }
    }
    
    func wantToCreateRoom() {
        let presenter = CreateRoomPresenter(roomService: roomService)
        let createRoomVC = CreateRoomViewController(output: presenter)
        presenter.viewInput = createRoomVC
        viewInput?.presentCreateRoom(vc: createRoomVC)
        createRoomVC.delegate = viewInput
    }
}
