//
//  JoinRoomViewOutput.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 21.05.2023.
//

import Foundation

protocol JoinRoomViewOutput {
    func viewIsReady()
    func wantToCreateRoom()
    func refreshRooms()
    func joinRoom(roomId: String, name: String, isAdmin: Bool)
}
