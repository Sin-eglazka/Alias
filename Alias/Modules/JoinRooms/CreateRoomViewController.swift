//
//  CreateRoomViewController.swift
//  Alias
//
//  Created by Kate on 20.05.2023.
//

import Foundation
import UIKit

class CreateRoomViewController: UIViewController{
    
    private lazy var mainView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var roomNameInput = { () -> UITextField in
        let input = UITextField()
        input.placeholder = "Room Name"
        input.borderStyle = .roundedRect
        input.autocapitalizationType = .none
        input.textColor = .darkGray
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
        setupContentView()
        setupjoinNameInput()
        setupcreateRoomButton
        
    }
    
    private func setupContentView() {
        view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            mainView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            mainView.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -30),
            mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: -40)
        ])
    }
    
    private func setupjoinNameInput() {
        mainView.addSubview(roomNameInput)
        roomNameInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            roomNameInput.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 5),
            roomNameInput.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -5),
            roomNameInput.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 5)
        ])
    }
    
    private func setupcreateRoomButton() {
        mainView.addSubview(createRoomButton)
        createRoomButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createRoomButton.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10),
            createRoomButton.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10)
        ])
        createRoomButton.addTarget(self, action: #selector(createRoom), for: .touchUpInside)
    }
    
    private func setupRefreshButton() {
        view.addSubview(refreshButton)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            refreshButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            refreshButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        ])
        refreshButton.addTarget(self, action: #selector(refreshRooms), for: .touchUpInside)
    }
    
    private func setupJoinPrivateButton() {
        view.addSubview(joinPrivateButton)
        joinPrivateButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            joinPrivateButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            joinPrivateButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            joinPrivateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
        joinPrivateButton.addTarget(self, action: #selector(joinPrivateRoom), for: .touchUpInside)
    }
    
    private func handleDelete(indexPath: IndexPath) {
        dataSource.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    @objc
    private func createRoom(_ sender: AnyObject) {
        present(CreateRoomViewController(), animated: true)
    }
    
    @objc
    private func refreshRooms(_ sender: AnyObject) {
        dataSource.removeAll()
        
        // get Rooms
        
        tableView.reloadData()
    }
    
    
}
