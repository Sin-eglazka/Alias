//
//  JoinRoomViewInput.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 21.05.2023.
//

import Foundation
import UIKit

protocol JoinRoomViewInput: AnyObject {
    func showRooms(_ data: [Room])
    func showAlert()
    func presentCreateRoom(vc: UIViewController)
}

