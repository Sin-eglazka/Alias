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
    
    init(roomService: RoomServiceProtocol) {
        self.roomService = roomService
    }
    
    private func loadRooms() {
        guard let token = (UserDefaults.standard.object(forKey: "bearer token") as? String) else {
            viewInput?.showAlert()
            return
        }
        
        roomService.listAllRooms(token: token) { [weak self] result in
            switch result {
            case let .success(rooms):
                self?.viewInput?.showRooms(rooms)
            case .failure:
                self?.viewInput?.showAlert()
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
    
    func joinRoom() {
        
    }
    
    func wantToCreateRoom() {
        let presenter = CreateRoomPresenter(roomService: roomService)
        let createRoomVC = CreateRoomViewController(output: presenter)
        presenter.viewInput = createRoomVC
        viewInput?.presentCreateRoom(vc: createRoomVC)
    }
}
