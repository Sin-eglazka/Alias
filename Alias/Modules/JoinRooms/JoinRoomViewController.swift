//
//  JoinRoomViewController.swift
//  Alias
//
//  Created by Kate on 20.05.2023.
//

import Foundation
import UIKit

class JoinRoomViewController: UIViewController{
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private var dataSource = [Room]()
    
    private lazy var joinCodeInput = { () -> UITextField in
        let input = UITextField()
        input.placeholder = "Private Code"
        input.borderStyle = .roundedRect
        input.autocapitalizationType = .none
        input.textColor = .darkGray
        return input
    }()
    
    private lazy var joinPrivateButton = { () -> UIButton in
        let button = UIButton()
        button.setTitle("Join", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    private lazy var logOutButton = { () -> UIButton in
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
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
        setupJoinCodeInput()
        setupLogoutButton()
        setupJoinPrivateButton()
        
        tableView.register(RoomCell.self,forCellReuseIdentifier:
                            RoomCell.reuseIdentifier)
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -4),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40)
        ])
        
        // test
        // let room = Room(isPrivate: true, id: "ossq", admin: "katya", name: "Hello World", creator: "katya", invitationCode: nil)
        // dataSource.append(room)
        tableView.reloadData()
    }
    
    private func setupJoinCodeInput() {
        view.addSubview(joinCodeInput)
        joinCodeInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            joinCodeInput.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            joinCodeInput.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            joinCodeInput.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -10)
        ])
        //joinCodeInput.delegate = self
    }
    
    
    private func setupLogoutButton() {
        view.addSubview(logOutButton)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logOutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            logOutButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        ])
        logOutButton.addTarget(self, action: #selector(logoutDidTouch), for: .touchUpInside)
    }
    
    private func setupJoinPrivateButton() {
        view.addSubview(joinPrivateButton)
        joinPrivateButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            joinPrivateButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            joinPrivateButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            joinPrivateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        joinPrivateButton.addTarget(self, action: #selector(joinPrivateRoom), for: .touchUpInside)
    }
    
    private func handleDelete(indexPath: IndexPath) {
        dataSource.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    @objc
    private func joinPrivateRoom(_ sender: AnyObject) {
        
    }
    
    @objc
    private func logoutDidTouch(_ sender: AnyObject) {
        
        
        // TODO: logout
    }
}

extension JoinRoomViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section {
        case 0:
            return 1
        default:
            return dataSource.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let room = dataSource[indexPath.row]
        if let roomCell = tableView.dequeueReusableCell(withIdentifier: RoomCell.reuseIdentifier, for: indexPath) as? RoomCell {
            roomCell.configure(room: room)
            return roomCell
        }
        
        return UITableViewCell()
    }
}



extension JoinRoomViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: .none
        ) { [weak self] (action, view, completion) in
            self?.handleDelete(indexPath: indexPath)
            completion(true)
        }
        deleteAction.image = UIImage(
            systemName: "trash.fill",
            withConfiguration: UIImage.SymbolConfiguration(weight: .bold))?.withTintColor(.white)
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
