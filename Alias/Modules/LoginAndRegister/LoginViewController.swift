//
//  LoginViewController.swift
//  Alias
//
//  Created by Kate on 19.05.2023.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController {
    
    private lazy var emailInput = {
        let input = UITextField()
        input.placeholder = "Email"
        input.borderStyle = .roundedRect
        input.autocapitalizationType = .none
        return input
    }()
    
    private lazy var passwordInput = {
        let input = UITextField()
        input.placeholder = "Password"
        input.borderStyle = .roundedRect
        input.autocapitalizationType = .none
        return input
    }()
    
    private lazy var loginButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    private lazy var signUpButton = {
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
        
        // test
        let service = UserService(networkService: NetworkService(), requestFactory: URLRequestFactory(host: Constants.baseUrl))
        service.register(name: "some12345", email: "name@gmail.com", password: "password") { result in
                switch result {
                case let .success(user):
                    print(user)
                case .failure:
                    print(result)
                }
        }
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
