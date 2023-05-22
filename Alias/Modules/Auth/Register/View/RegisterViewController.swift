//
//  RegisterViewController.swift
//  Alias
//
//  Created by Kate on 19.05.2023.
//

import Foundation
import UIKit

final class RegisterViewController: UIViewController {
    
    private var output: RegisterViewOutput
    
    private lazy var nameInput = { () -> UITextField in
        let input = UITextField()
        input.placeholder = "Name"
        input.borderStyle = .roundedRect
        input.autocapitalizationType = .none
        return input
    }()
    
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
    
    private lazy var signUpButton = { () -> UIButton in
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    // MARK: Lifecycle
    
    init(output: RegisterViewOutput) {
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
    
    private func setupView() {
        setupNameInput()
        setupEmailInput()
        setupPasswordInput()
        setupButton()
    }
    
    private func setupNameInput() {
        view.addSubview(nameInput)
        nameInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameInput.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            nameInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            nameInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36)
        ])
        nameInput.delegate = self
    }
    
    private func setupEmailInput() {
        view.addSubview(emailInput)
        emailInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailInput.topAnchor.constraint(equalTo: nameInput.bottomAnchor, constant: 16),
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
    
    private func setupButton() {
        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 16),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        signUpButton.addTarget(self, action: #selector(signUpDidTouch), for: .touchUpInside)
    }
    
    @objc
    private func signUpDidTouch(_ sender: AnyObject) {
        guard
            let name = nameInput.text,
            let email = emailInput.text,
            let password = passwordInput.text,
            !email.isEmpty,
            !password.isEmpty,
            password.count > 7,
            !name.isEmpty
        else { return }
        
        output.signUp(name: name, email: email, password: password)
    }
}

extension RegisterViewController: RegisterViewInput {
    
    func signUpSuccessed() {
        // TODO: success alert
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Message", message: "Success registration", preferredStyle: .alert)
            alert.addAction(UIAlertAction(
                title: NSLocalizedString("OK", comment: "Default action"),
                style: .default,
                handler: { _ in
                    self?.dismiss(animated: true)
                })
            )
            self?.present(alert, animated: true)
        }
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
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameInput:
            emailInput.becomeFirstResponder()
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
