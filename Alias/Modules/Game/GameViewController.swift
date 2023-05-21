//
//  CreateRoomViewController.swift
//  Alias
//
//  Created by Kate on 20.05.2023.
//

import Foundation
import UIKit

class GameViewController: UIViewController{
    
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private var dataSource = [[String]]()
    
    private lazy var settingsButton = { () -> UIButton in
        let button = UIButton()
        button.setTitle("Settings", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    private lazy var leaveButton = { () -> UIButton in
        let button = UIButton()
        button.setTitle("Leave", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    private var roomId, name: String
    private var isAdmin: Bool
    
    init (roomId: String, name: String, isAdmin: Bool){
        self.roomId = roomId
        self.name = name
        self.isAdmin = isAdmin
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    private func setupView() {
        setupSettingsButton()
        setupLeaveButton()
        setupTableView()
        view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        
        // Test
        
        dataSource = [["Katya", "Liza"], ["Vova"]]
        
        // end Test
    }
    
    private func setupTableView() {
        tableView.register(TeamCell.self,forCellReuseIdentifier: TeamCell.reuseIdentifier)
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 80)
        ])
    }
    
    private func setupSettingsButton() {
        view.addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            settingsButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
        ])
        settingsButton.addTarget(self, action: #selector(settingsDidTouch), for: .touchUpInside)
    }
    
    private func setupLeaveButton() {
        view.addSubview(leaveButton)
        leaveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leaveButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            leaveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10)
        ])
        leaveButton.addTarget(self, action: #selector(leaveRoom), for: .touchUpInside)
    }
    
    @objc
    private func leaveRoom(_ sender: AnyObject) {
        
        // TODO send request for leaving room
        

        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func settingsDidTouch(_ sender: AnyObject) {
        
        // TODO check if user an admin
        let settingsVC = SettingsViewController(isAdmin: true)
        settingsVC.delegate = self
        present(settingsVC, animated: true)
    }
    
    func updateParticipants(){
        dataSource.removeAll()
        
        // TODO add in dataSource list of groups (at index 0 participants without team)
        
        // dataSource = list of groups (at index 0 participants without team)
        
        tableView.reloadData()
    }
    
    private func handleDelete(indexPath: IndexPath) {
        if (indexPath.row == 0){
            return
        }
        
        if (isAdmin){
            
            // TODo delete team with index indexPath.row - 1
            
            dataSource.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    
    
}

protocol DeletingRoom: AnyObject{
    func deleteRoom()
}
extension GameViewController: DeletingRoom{
    
    func deleteRoom() {
        // TODO delete room
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension GameViewController: UITableViewDataSource {
 
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
        switch indexPath.row {
            case 0:
                if let participantCell = tableView.dequeueReusableCell(withIdentifier: TeamCell.reuseIdentifier, for: indexPath) as? TeamCell {
                    participantCell.setIsTeam(isTeam: false)
                    participantCell.configure(usernames: dataSource[indexPath.row])
                    return participantCell
                }
            default:
                let list = dataSource[indexPath.row]
                if let teamCell = tableView.dequeueReusableCell(withIdentifier: TeamCell.reuseIdentifier, for: indexPath) as? TeamCell {
                    teamCell.configure(usernames: list)
                        return teamCell
                }
            }
        return UITableViewCell()
    }
}

extension GameViewController: UITableViewDelegate {
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
