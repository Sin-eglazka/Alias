//
//  GameViewInput.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 22.05.2023.
//

import Foundation
import UIKit

protocol GameViewInput: AnyObject {
    func showTeams(_ data: [Team])
    func showAlert(title: String, text: String)
    func presentSettings(vc: UIViewController)
    func updateAfterAddingTeam()
}
