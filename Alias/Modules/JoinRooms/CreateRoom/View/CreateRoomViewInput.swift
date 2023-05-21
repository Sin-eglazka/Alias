//
//  CreateRoomViewInput.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 21.05.2023.
//

import Foundation

protocol CreateRoomViewInput: AnyObject {
    func roomWasAdded(_ data: GameRoom)
    func showAlert()
}
