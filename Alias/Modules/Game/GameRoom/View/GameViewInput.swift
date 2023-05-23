//
//  GameViewInput.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 22.05.2023.
//

import Foundation

protocol GameViewInput: AnyObject {
    func showTeams(_ data: [Team])
    func showAlert(title: String, text: String)
    func presentSettings(output: SettingsViewOutput)
    func updateAfterAddingTeam()
    func leaveRoom()
    func updateRound(state: String)
}
