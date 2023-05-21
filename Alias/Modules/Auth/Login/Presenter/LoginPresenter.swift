//
//  LoginPresenter.swift
//  Alias
//
//  Created by Elizaveta Shelemekh on 21.05.2023.
//

import Foundation

final class LoginPresenter {
    
    weak var viewInput: LoginViewInput?
    
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol) {
        self.userService = userService
    }
}

extension LoginPresenter: LoginViewOutput {
    
    func login(email: String, password: String) {
        userService.login(email: email, password: password) { [weak self] result in
            switch result {
            case let .success(user):
                UserDefaults.standard.set(user.value, forKey: "bearer token")
                print(user.value)
                self?.viewInput?.loginSuccessed()
            case .failure:
                // TODO: show alert
                print(result)
                self?.viewInput?.showAlert()
            }
        }
    }
    
    func signUp() {
        let presenter = RegisterPresenter(userService: userService)
        let registerVC = RegisterViewController(output: presenter)
        presenter.viewInput = registerVC
        viewInput?.presentSignUp(vc: registerVC)
    }
}
