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
    private let roomService: RoomServiceProtocol
    
    init(userService: UserServiceProtocol, roomService: RoomServiceProtocol) {
        self.userService = userService
        self.roomService = roomService
    }
}

extension LoginPresenter: LoginViewOutput {
    
    func login(email: String, password: String) {
        userService.login(email: email, password: password) { [weak self] result in
            switch result {
            case let .success(user):
                guard let roomService = self?.roomService,
                      let userService = self?.userService else { return }
                UserDefaults.standard.set(user.value, forKey: "bearer token")
                print(UserDefaults.standard.object(forKey: "bearer token"))
                DispatchQueue.main.async {
                    let presenter = JoinRoomPresenter(roomService: roomService, userService: userService)
                    let vc = JoinRoomViewController(output: presenter)
                    presenter.viewInput = vc
                    self?.viewInput?.loginSuccessed(vc: vc)
                }
            case .failure:
                self?.viewInput?.showAlert(title: "Server Error", text: "Couldn't login this user")
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
