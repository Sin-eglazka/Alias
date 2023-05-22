//
//  LoginViewInput.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 21.05.2023.
//

import Foundation
import UIKit

protocol LoginViewInput: AnyObject {
    func loginSuccessed()
    func showAlert(title: String, text: String)
    func presentSignUp(vc: UIViewController)
}


