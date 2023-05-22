//
//  RegisterPresenter.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 21.05.2023.
//

import Foundation

final class RegisterPresenter {
    
    weak var viewInput: RegisterViewInput?
    
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol) {
        self.userService = userService
    }
}

extension RegisterPresenter: RegisterViewOutput {
    
    func signUp(name: String, email: String, password: String) {
        userService.register(name: name, email: email, password: password) { [weak self] result in
            switch result {
            case let .success(user):
                print(user)
                self?.viewInput?.signUpSuccessed()
            case .failure:
                // TODO: show alert
                print(result)
                self?.viewInput?.showAlert(title: "Server Error", text: "Couldn't register this user")
            }
        }
    }
}
