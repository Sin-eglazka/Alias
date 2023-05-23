//
//  SettingsPresenter.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 24.05.2023.
//

import Foundation

final class SettingsPresenter {
    
    weak var viewInput: SettingsViewInput?
    
    // MARK: - Private properties
    
    private let roomService: RoomServiceProtocol
    private let room: JoinRoomResponse
    private let token = (UserDefaults.standard.object(forKey: "bearer token") as? String)
    
    // MARK: - Lifecycle
    
    init(room: JoinRoomResponse, roomService: RoomServiceProtocol) {
        self.roomService = roomService
        self.room = room
    }
}

extension SettingsPresenter: SettingsViewOutput {
    
    func viewIsReady() {
        viewInput?.fillRoomInfo(name: room.name, points: room.points)
    }
    
    func setupView(vc: SettingsViewInput) {
        viewInput = vc
    }
    
    func applyChanges(name: String, points: Int) {
        guard let token = token else {
            viewInput?.showAlert(title: "Server error", text: "broken auth")
            return
        }
        
        roomService.changeSettingsInRoom(for: room.id,
                                         points: points,
                                         isPrivate: room.isPrivate,
                                         name: name,
                                         with: token) { [weak self] result in
            switch result {
            case let .success(room):
                self?.viewInput?.updateSettingsSuccessed(newRoom: room)
            case .failure:
                self?.viewInput?.showAlert(title: "Server Error", text: "Only admin can change settings")
            }
        }
    }
    
    func deleteRoom() {
        
    }
}

