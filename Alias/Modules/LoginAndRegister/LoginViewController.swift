//
//  LoginViewController.swift
//  Alias
//
//  Created by Kate on 19.05.2023.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController {
    
    private lazy var emailInput = { () -> UITextField in
        let input = UITextField()
        input.placeholder = "Email"
        input.borderStyle = .roundedRect
        input.autocapitalizationType = .none
        return input
    }()
    
    private lazy var passwordInput = { () -> UITextField in
        let input = UITextField()
        input.placeholder = "Password"
        input.borderStyle = .roundedRect
        input.autocapitalizationType = .none
        return input
    }()
    
    private lazy var loginButton = { () -> UIButton in
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    private lazy var signUpButton = { () -> UIButton in
        let button = UIButton()
        button.setTitle("Sign up?", for: .normal)
        button.setTitleColor(UIColor.systemGray4, for: .normal)
        return button
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    private func setupView() {
        setupEmailInput()
        setupPasswordInput()
        setupLoginButton()
        setupSignUpButton()
        
        
        //        let service = UserService(networkService: NetworkService(), requestFactory: URLRequestFactory(host: Constants.localBaseURL))
        //        service.login(email: "some@gmail.com", password: "qwerty123456789") { result in
        //                switch result {
        //                case let .success(user):
        //                    print(user)
        //                case .failure:
        //                    print(result)
        //                }
        //        }
        
//        let service = RoomService(networkService: NetworkService(), requestFactory: URLRequestFactory(host: Constants.localBaseURL))
//        service.listAllRooms(token: "Lpsb/o7rPel2Aqws0SQIu3kiXRF4aNN9p96gBuaaNpc="){ result in
//            switch result {
//            case let .success(rooms):
//                print(rooms)
//            case .failure:
//                print(result)
//            }
//        }
        
//        let service = RoomService(networkService: NetworkService(), requestFactory: URLRequestFactory(host: Constants.localBaseURL))
//        service.createRoom(name: "room name", isPrivate: false, token: "Lpsb/o7rPel2Aqws0SQIu3kiXRF4aNN9p96gBuaaNpc="){ result in
//            switch result {
//            case let .success(room):
//                print(room)
//            case .failure:
//                print(result)
//            }
//        }
        
//        let service = RoomService(networkService: NetworkService(), requestFactory: URLRequestFactory(host: Constants.localBaseURL))
//        service.joinRoom(gameRoomId: "4F4E50DE-CED8-4B84-A925-C93CE11C90A3", invitationCode: "I1S2t", token: "Lpsb/o7rPel2Aqws0SQIu3kiXRF4aNN9p96gBuaaNpc=") { result in
//            switch result {
//            case let .success(room):
//                print(room)
//            case .failure:
//                print(result)
//            }
//        }
        
//        let service = RoomService(networkService: NetworkService(), requestFactory: URLRequestFactory(host: Constants.localBaseURL))
//        service.leaveRoom(gameRoomId: "4F4E50DE-CED8-4B84-A925-C93CE11C90A3",
//                           token: "Lpsb/o7rPel2Aqws0SQIu3kiXRF4aNN9p96gBuaaNpc=") { result in
//            switch result {
//            case let .success(room):
//                print(room)
//            case .failure:
//                print(result)
//            }
//        }
    }
    
    private func setupEmailInput() {
        view.addSubview(emailInput)
        emailInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailInput.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -70),
            emailInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            emailInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36)
        ])
        emailInput.delegate = self
    }
    
    private func setupPasswordInput() {
        view.addSubview(passwordInput)
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 16),
            passwordInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            passwordInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36)
        ])
        passwordInput.delegate = self
    }
    
    private func setupLoginButton() {
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 16),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        loginButton.addTarget(self, action: #selector(loginDidTouch), for: .touchUpInside)
    }
    
    private func setupSignUpButton() {
        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        signUpButton.addTarget(self, action: #selector(signUpDidTouch), for: .touchUpInside)
    }
    
    @objc
    private func signUpDidTouch(_ sender: AnyObject) {
        present(RegisterViewController(), animated: true)
    }
    
    @objc
    private func loginDidTouch(_ sender: AnyObject) {
        guard
            let email = emailInput.text,
            let password = passwordInput.text,
            !email.isEmpty,
            !password.isEmpty
        else { return }
        
        // TODO: login
        
        //
        
        print("join")
        let joinController = JoinRoomViewController()
        self.navigationController?.pushViewController(joinController, animated: true)
        //present(JoinRoomViewController(), animated: true)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailInput:
            passwordInput.becomeFirstResponder()
        case passwordInput:
            textField.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
