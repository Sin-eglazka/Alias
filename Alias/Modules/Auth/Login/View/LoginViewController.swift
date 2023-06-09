//
//  LoginViewController.swift
//  Alias
//
//  Created by Kate on 19.05.2023.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var output: LoginViewOutput
    
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
        input.isSecureTextEntry = true
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
    
    init(output: LoginViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    // MARK: - View setup
    
    private func setupView() {
        setupEmailInput()
        setupPasswordInput()
        setupLoginButton()
        setupSignUpButton()
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
    
    // MARK: - Action targets
    
    @objc
    private func signUpDidTouch(_ sender: AnyObject) {
        output.signUp()
    }
    
    @objc
    private func loginDidTouch(_ sender: AnyObject) {
        guard
            let email = emailInput.text,
            let password = passwordInput.text,
            !email.isEmpty,
            !password.isEmpty
        else { return }
        
        output.login(email: email, password: password)
        emailInput.text = ""
        passwordInput.text = ""
    }
}

// MARK: - LoginViewInput

extension LoginViewController: LoginViewInput {
    
    func loginSuccessed(vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAlert(title: String, text: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
            alert.addAction(UIAlertAction(
                title: NSLocalizedString("OK", comment: "Default action"),
                style: .default,
                handler: { _ in })
            )
            self?.present(alert, animated: true)
        }
    }
    
    func presentSignUp(vc: UIViewController) {
        present(vc, animated: true)
    }
}

// MARK: - UITextFieldDelegate

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
