//
//  JoinRoomViewController.swift
//  Alias
//
//  Created by Kate on 20.05.2023.
//

import Foundation
import UIKit

class JoinRoomViewController: UIViewController {
    
    private var output: JoinRoomViewOutput
    
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
        let image = UIImage(named: "refresh-25")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    private lazy var createRoomButton = { () -> UIButton in
        let button = UIButton()
        button.setTitle("Create Room", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    private lazy var refreshButton = { () -> UIButton in
        let button = UIButton()
        // button.setTitle("Refresh", for: .normal)
        let image = UIImage(systemName: "arrow.triangle.2.circlepath")?.withTintColor(.systemBlue)
        button.setImage(image, for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    
    // MARK: Lifecycle
    
    init(output: JoinRoomViewOutput) {
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
    
    private func setupTableView() {
        tableView.register(RoomCell.self,forCellReuseIdentifier: RoomCell.reuseIdentifier)
        view.addSubview(tableView)
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = .clear
        // TODO: Presenter
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: createRoomButton.topAnchor, constant: -16),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8),
            tableView.topAnchor.constraint(equalTo: joinCodeInput.bottomAnchor, constant: 8)
        ])
        tableView.delegate = self
    }
    
    private func setupView() {
        setupLogoutButton()
        setupRefreshButton()
        setupJoinCodeInput()
        setupJoinPrivateButton()
        setupCreateRoomButton()
        setupTableView()
        output.viewIsReady()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupJoinCodeInput() {
        view.addSubview(joinCodeInput)
        joinCodeInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            joinCodeInput.topAnchor.constraint(equalTo: refreshButton.bottomAnchor, constant: 16),
            joinCodeInput.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            joinCodeInput.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -10)
        ])
    }
    
    private func setupCreateRoomButton() {
        view.addSubview(createRoomButton)
        createRoomButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createRoomButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            createRoomButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            createRoomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
        createRoomButton.addTarget(self, action: #selector(createRoom), for: .touchUpInside)
    }
    
    private func setupLogoutButton() {
        view.addSubview(logOutButton)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logOutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            logOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
        logOutButton.addTarget(self, action: #selector(logoutDidTouch), for: .touchUpInside)
    }
    
    private func setupRefreshButton() {
        view.addSubview(refreshButton)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            refreshButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            refreshButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
        refreshButton.addTarget(self, action: #selector(refreshRooms), for: .touchUpInside)
    }
    
    private func setupJoinPrivateButton() {
        view.addSubview(joinPrivateButton)
        joinPrivateButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            joinPrivateButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            joinPrivateButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            joinPrivateButton.topAnchor.constraint(equalTo: refreshButton.bottomAnchor, constant: 16),
        ])
        joinPrivateButton.addTarget(self, action: #selector(joinPrivateRoom), for: .touchUpInside)
    }
    
    private func handleDelete(indexPath: IndexPath) {
        dataSource.remove(at: indexPath.row)
        
        // TODO: delete room
        
        tableView.reloadData()
    }
    
    @objc
    private func createRoom(_ sender: AnyObject) {
        output.wantToCreateRoom()
    }
    
    @objc
    private func refreshRooms(_ sender: AnyObject) {
        output.refreshRooms()
    }
    
    @objc
    private func joinPrivateRoom(_ sender: AnyObject) {
        
        //TODO get room and join it
        
        var id = ""
        var name = ""
        var isAdmin = true
        self.navigationController?.pushViewController(GameViewController(roomId: id, name: name, isAdmin: isAdmin), animated: true)
        
    }
    
    @objc
    private func logoutDidTouch(_ sender: AnyObject) {
        
        
        // TODO: logout
        
        self.navigationController?.popViewController(animated: true)
        //self.navigationController?.popToRootViewController(animated: true)
    }
}

extension JoinRoomViewController: JoinRoomViewInput {
    
    func updateAfterAddingRoom() {
        DispatchQueue.main.async { [weak self] in
            self?.output.refreshRooms()
        }
    }
    
    func showRooms(_ data: [Room]) {
        dataSource = data
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func showAlert(title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("OK", comment: "Default action"),
            style: .default,
            handler: { _ in })
        )
        alert.addAction(UIAlertAction(
            title: NSLocalizedString("Copy", comment: "Default action"),
            style: .default,
            handler: { _ in
                UIPasteboard.general.string = alert.message
            })
        )
        present(alert, animated: true)
    }
    
    func presentCreateRoom(vc: UIViewController) {
        present(vc, animated: true)
    }
}

extension JoinRoomViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(GameViewController(roomId: "id", name: "name", isAdmin: true), animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension JoinRoomViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        default:
            return dataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (dataSource.isEmpty){
            return UITableViewCell()
        }
        let room = dataSource[indexPath.row]
        if let roomCell = tableView.dequeueReusableCell(withIdentifier: RoomCell.reuseIdentifier, for: indexPath) as? RoomCell {
            roomCell.configure(room: room)
            // roomCell.delegate = self
            return roomCell
        }
        
        return UITableViewCell()
    }
}
