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
    
    private var dataSource = [Team]()
    private var participants = [TeamPlayer]()
    
    private var output: GameViewOutput
    
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
    
    private lazy var startRoundButton = { () -> UIButton in
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    private lazy var pauseRoundButton = { () -> UIButton in
        let button = UIButton()
        button.setTitle("Pause", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    private lazy var createTeamButton = { () -> UIButton in
        let button = UIButton()
        button.setTitle("Create Team", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    private lazy var teamNameField = { () -> UITextField in
        let input = UITextField()
        input.placeholder = "Team Name"
        input.borderStyle = .roundedRect
        input.autocapitalizationType = .none
        input.textColor = .darkGray
        return input
    }()
    
    private lazy var mainTitle = { () -> UILabel in
        let label = UILabel()
        label.text = name
        label.textColor = .systemBlue
        label.textAlignment = .center
        //label.font = .systemFont(ofSize: 25,weight: .regular)
        return label
    }()
    
    private lazy var infoLabel = { () -> UILabel in
        let label = UILabel()
        label.text = "Game not started"
        label.textColor = .black
        label.textAlignment = .center
        //label.font = .systemFont(ofSize: 25, weight: .regular)
        return label
    }()
    
    private var roomId, name: String
    private var isAdmin: Bool
    
    // MARK: Lifecycle
    
    init (roomId: String, name: String, isAdmin: Bool, output: GameViewOutput){
        self.roomId = roomId
        self.name = name
        self.isAdmin = isAdmin
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        output.viewIsReady()
    }
    
    private func setupView() {
        setupSettingsButton()
        setupLeaveButton()
        setupTitleLabel()
        setupStartButton()
        setupPauseButton()
        setupInfoLabel()
        setupCreateTeamButton()
        setupInputTeamName()
        setupTableView()
        
        view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupTableView() {
        tableView.register(TeamCell.self,forCellReuseIdentifier: TeamCell.reuseIdentifier)
        tableView.register(ParticipantsCell.self, forCellReuseIdentifier: ParticipantsCell.reuseIdentifier)
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: teamNameField.topAnchor, constant: -10)
        ])
    }
    
    private func setupInfoLabel() {
        view.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            infoLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            infoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        ])
    }
    
    private func setupTitleLabel() {
        view.addSubview(mainTitle)
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            mainTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70),
            mainTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70)
        ])
    }
    
    private func setupInputTeamName() {
        view.addSubview(teamNameField)
        teamNameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            teamNameField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            teamNameField.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            teamNameField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10)
        ])
    }
    
    private func setupCreateTeamButton() {
        view.addSubview(createTeamButton)
        createTeamButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createTeamButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            createTeamButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            createTeamButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 10)
        ])
        createTeamButton.addTarget(self, action: #selector(createTeam), for: .touchUpInside)
    }
    
    private func setupPauseButton() {
        view.addSubview(pauseRoundButton)
        pauseRoundButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pauseRoundButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            pauseRoundButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            pauseRoundButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 10)
        ])
        pauseRoundButton.addTarget(self, action: #selector(pauseRound), for: .touchUpInside)
    }
    
    private func setupStartButton() {
        view.addSubview(startRoundButton)
        startRoundButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startRoundButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            startRoundButton.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            startRoundButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10)
        ])
        startRoundButton.addTarget(self, action: #selector(startRound), for: .touchUpInside)
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
    private func pauseRound(_ sender: AnyObject) {
        
        // TODO send request pause round
        
        infoLabel.text = "Game was paused"
        
        
    }
    
    @objc
    private func startRound(_ sender: AnyObject) {
        
        if (dataSource.count < 3){
            DispatchQueue.main.async { [weak self] in
                let alert = UIAlertController(title: "Game Error", message: "Number of teams must be more than 1", preferredStyle: .alert)
                alert.addAction(UIAlertAction(
                    title: NSLocalizedString("OK", comment: "Default action"),
                    style: .default,
                    handler: { _ in })
                )
                self?.present(alert, animated: true)
            }
            return
        }
        // TODO send request for start round
        
        infoLabel.text = "Game was started"
    }
    
    @objc
    private func leaveRoom(_ sender: AnyObject) {
        
        // TODO send request for leaving room
        
    }
    
    @objc
    private func createTeam(_ sender: AnyObject) {
        
        guard let name = teamNameField.text,
                !name.isEmpty
        else {
            return
        }
        
        output.createTeam(with: name)
        
        // TODO send request for adding team
//
//        var users = TeamPlayer(id: "", name: "Katya")
//        var usr2 = TeamPlayer(id: "", name: "Liza")
//        var team = Team(id: "", name: teamNameField.text ?? "", users: [users, usr2])
//
//        dataSource.append(team)
//        tableView.reloadData()
//        teamNameField.text = ""
//
    }
    
    @objc
    private func settingsDidTouch(_ sender: AnyObject) {
        
        // TODO check if user an admin
        let settingsVC = SettingsViewController(isAdmin: true)
        // settingsVC.delegate = self
        present(settingsVC, animated: true)
    }
    
    func updateParticipants(){
        dataSource.removeAll()
        participants.removeAll()
        // TODO add in dataSource list of groups and add in participants all participants
        
        // dataSource = list of groups
        // participants = list of TeamPlayer
        
        tableView.reloadData()
    }
    
    private func handleDelete(indexPath: IndexPath) {
        if (isAdmin){
            
            // TODo delete team with index indexPath.row
            
            dataSource.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

extension GameViewController: GameViewInput {
    
    func showTeams(_ data: [Team]) {
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
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
    
    func presentSettings(vc: UIViewController) {
        
    }
    
    func updateAfterAddingTeam() {
        DispatchQueue.main.async { [weak self] in
            self?.output.refreshTeams()
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
        
        switch indexPath.section {
        case 0:
            if let participantCell = tableView.dequeueReusableCell(withIdentifier: ParticipantsCell.reuseIdentifier, for: indexPath) as? ParticipantsCell {
                
                participantCell.configure(usernames: participants)
                return participantCell
            }
        default:
            let list = dataSource[indexPath.row]
            if let teamCell = tableView.dequeueReusableCell(withIdentifier: TeamCell.reuseIdentifier, for: indexPath) as? TeamCell {
                teamCell.setIsTeam(isTeam: true)
                teamCell.configure(usernames: list.users, title: list.name)
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
