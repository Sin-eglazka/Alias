//
//  SettingsViewOutput.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 24.05.2023.
//

import Foundation

protocol SettingsViewOutput {
    func applyChanges(name: String, points: Int)
    func deleteRoom()
    func viewIsReady()
    func setupView(vc: SettingsViewInput)
}
