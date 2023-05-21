//
//  CreateRoomPresenter.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 21.05.2023.
//

import Foundation

final class CreateRoomPresenter {
    
    weak var viewInput: CreateRoomViewInput?
    
    private let roomService: RoomServiceProtocol
    
    init(roomService: RoomServiceProtocol) {
        self.roomService = roomService
    }

}

extension CreateRoomPresenter: CreateRoomViewOutput {
    
    func createRoom(name: String, isPrivate: Bool) {
        guard let token = (UserDefaults.standard.object(forKey: "bearer token") as? String) else {
             viewInput?.showAlert(text: "Server error")
            return
        }
        
        roomService.createRoom(name: name, isPrivate: isPrivate, token: token) { [weak self] result in
            switch result {
            case let .success(room):
                self?.viewInput?.roomWasAdded(room)
            case .failure:
                self?.viewInput?.showAlert(text: "Server error")
            }
        }
    }

}
