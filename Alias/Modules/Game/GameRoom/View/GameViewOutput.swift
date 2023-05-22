//
//  GameViewOutput.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 22.05.2023.
//

import Foundation

protocol GameViewOutput {
    func viewIsReady()
    func wantToStartRound()
    func wantToPauseRound()
    func createTeam(with name: String)
    func changeSettings()
    func leaveRoom()
    func joinTeam()
}
