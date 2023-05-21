//
//  CreateRoomViewController.swift
//  Alias
//
//  Created by Kate on 20.05.2023.
//

import Foundation
import UIKit

class CreateRoomViewController: UIViewController {
    
    private var output: CreateRoomViewOutput
    weak var delegate: JoinRoomViewInput?
    
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
    
    init(output: CreateRoomViewOutput) {
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
        setupjoinNameInput()
        setupPrivateToggle()
        setupcreateRoomButton()
    }
    
    private func setupjoinNameInput() {
        view.addSubview(roomNameInput)
        roomNameInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            roomNameInput.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            roomNameInput.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            roomNameInput.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -16),
        ])
        roomNameInput.delegate = self
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
        guard
            let name = roomNameInput.text,
            !name.isEmpty
        else { return }
        output.createRoom(name: name, isPrivate: isPrivteToggle.isOn)
    }
    
}

extension CreateRoomViewController: CreateRoomViewInput {
    
    func roomWasAdded(_ data: GameRoom) {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.updateAfterAddingRoom()
            self?.dismiss(animated: true)
            if data.isPrivate {
                self?.delegate?.showAlert(title: "Invitation code", text: "\(data.id)&\(data.invitationCode ?? "")")
            }
        }
    }
    
    func showAlert(text: String) {
        
    }
    
}

extension CreateRoomViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
