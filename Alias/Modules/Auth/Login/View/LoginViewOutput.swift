//
//  LoginViewOutput.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 21.05.2023.
//

import Foundation

protocol LoginViewOutput {
    func login(email: String, password: String)
    func signUp()
}
