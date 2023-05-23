//
//  SettingsViewInput.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 24.05.2023.
//

import Foundation

protocol SettingsViewInput: AnyObject {
    func updateSettingsSuccessed(newRoom: Room)
    func showAlert(title: String, text: String)
    func fillRoomInfo(name: String, points: Int)
}


