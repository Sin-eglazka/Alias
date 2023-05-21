//
//  CreateRoomViewController.swift
//  Alias
//
//  Created by Kate on 20.05.2023.
//

import Foundation
import UIKit

class CreateRoomViewController: UIViewController {
    
//    private lazy var mainView = { () -> UIView in
//        let view = UIView()
//        view.layer.cornerRadius = 20
//        view.backgroundColor = .white
//        return view
//    }()
    
    private lazy var roomNameInput = { () -> UITextField in
        let input = UITextField()
        input.placeholder = "Room Name"
        input.borderStyle = .roundedRect
        input.autocapitalizationType = .none
        input.textColor = .black
        return input
    }()
    
    private lazy var isPrivteToggle = { () -> UISwitch in
        let toggle = UISwitch()
        toggle.setOn(false, animated: false)
        return toggle
    }()
    
    private lazy var toggleLabel = { () -> UILabel in
        let label = UILabel()
        label.text = "Private"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    private lazy var createRoomButton = { () -> UIButton in
        let button = UIButton()
        button.setTitle("Create Room", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    
    private func setupView() {
        // setupContentView()
        setupjoinNameInput()
        setupPrivateToggle()
        setupcreateRoomButton()
//        var horStack = UIStackView(arrangedSubviews: [isPrivteToggle, toggleLabel])
//        horStack.distribution = .fillEqually
//        horStack.axis = .horizontal
//        var stack = UIStackView(arrangedSubviews: [roomNameInput, horStack, createRoomButton])
//        mainView.addSubview(stack)
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            stack.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 5),
//            stack.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -5),
//            stack.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5),
//            stack.bottomAnchor.constraint(equalTo: mainView.topAnchor, constant: -5)
//        ])
//        stack.axis = .vertical
//        stack.distribution = .fillEqually
        
    }
    
//    private func setupContentView() {
//        view.addSubview(mainView)
//        mainView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
//            mainView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
//            mainView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
//            mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60)
//        ])
//    }
    
    private func setupjoinNameInput() {
        view.addSubview(roomNameInput)
        roomNameInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            roomNameInput.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            roomNameInput.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            roomNameInput.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -16),
        ])
    }

    private func setupPrivateToggle() {
        view.addSubview(isPrivteToggle)
        isPrivteToggle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            isPrivteToggle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            isPrivteToggle.topAnchor.constraint(equalTo: roomNameInput.bottomAnchor, constant: 16)
        ])
        
        view.addSubview(toggleLabel)
        toggleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toggleLabel.trailingAnchor.constraint(equalTo: isPrivteToggle.leadingAnchor, constant: -5),
            toggleLabel.topAnchor.constraint(equalTo: roomNameInput.bottomAnchor, constant: 16)
        ])
    }
    
    private func setupcreateRoomButton() {
        view.addSubview(createRoomButton)
        createRoomButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createRoomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createRoomButton.topAnchor.constraint(equalTo: isPrivteToggle.bottomAnchor, constant: 16)
        ])
        createRoomButton.addTarget(self, action: #selector(createRoom), for: .touchUpInside)
    }
    
    
    
    @objc
    private func createRoom(_ sender: AnyObject) {
        // ToDo create room 
    }

}
