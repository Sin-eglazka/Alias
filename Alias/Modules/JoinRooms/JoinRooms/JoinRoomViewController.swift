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
        button.setTitle("Refresh", for: .normal)
        let image = UIImage(named: "refresh-25")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    fileprivate func setupTableView() {
        tableView.register(RoomCell.self,forCellReuseIdentifier:
                            RoomCell.reuseIdentifier)
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -4),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60)
        ])
    }
    
    private func setupView() {
        setupJoinCodeInput()
        setupLogoutButton()
        setupJoinPrivateButton()
        setupTableView()
        setupRefreshButton()
        setupCreateRoomButton()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // test
        var room = Room(isPrivate: true, id: "ossq", admin: "katya", name: "Hello World", creator: "katya", invitationCode: nil)
        dataSource.append(room)
        tableView.reloadData()
        // end test
    }
    
    private func setupJoinCodeInput() {
        view.addSubview(joinCodeInput)
        joinCodeInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            joinCodeInput.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
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
            logOutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            logOutButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30)
        ])
        logOutButton.addTarget(self, action: #selector(logoutDidTouch), for: .touchUpInside)
    }
    
    private func setupRefreshButton() {
        view.addSubview(refreshButton)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            refreshButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            refreshButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30)
        ])
        refreshButton.addTarget(self, action: #selector(refreshRooms), for: .touchUpInside)
    }
    
    private func setupJoinPrivateButton() {
        view.addSubview(joinPrivateButton)
        joinPrivateButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            joinPrivateButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            joinPrivateButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            joinPrivateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
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
        
        //TODO get Rooms
        
        tableView.reloadData()
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

extension JoinRoomViewController: UITableViewDataSource {
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
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
                    roomCell.delegate = self
                    return roomCell
                }
            
        return UITableViewCell()
    }
}





protocol JoiningRoom: AnyObject{
    func joinRoom(id: String, name: String)
}

extension JoinRoomViewController: JoiningRoom{
    func joinRoom(id: String, name: String) {
        
        // TODO check if room available, after join it and get isAdmin property
        var isAdmin = true
        self.navigationController?.pushViewController(GameViewController(roomId: id, name: name, isAdmin: isAdmin), animated: true)
    }
}
