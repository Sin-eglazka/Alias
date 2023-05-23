//
//  CreateRoomViewController.swift
//  Alias
//
//  Created by Kate on 20.05.2023.
//

import Foundation
import UIKit

class GameViewController: UIViewController {
    
    // MARK: - Private properties
    
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
        button.setTitleColor(UIColor.systemGray, for: .disabled)
        return button
    }()
    
    private lazy var pauseRoundButton = { () -> UIButton in
        let button = UIButton()
        button.setTitle("Pause", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.setTitleColor(UIColor.systemGray, for: .disabled)
        button.isEnabled = false
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
        label.text = room.name
        label.textColor = .systemBlue
        label.textAlignment = .center
        return label
    }()
    
    private lazy var infoLabel = { () -> UILabel in
        let label = UILabel()
        label.text = "Game not started"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private var room: JoinRoomResponse
    
    // MARK: Lifecycle
    
    init (room: JoinRoomResponse, output: GameViewOutput){
        self.room = room
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
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - View setup
    
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
            tableView.topAnchor.constraint(equalTo: teamNameField.bottomAnchor, constant: 10),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: pauseRoundButton.topAnchor, constant: -10)
        ])
    }
    
    private func setupInfoLabel() {
        view.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 16),
            infoLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            infoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        ])
    }
    
    private func setupTitleLabel() {
        view.addSubview(mainTitle)
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            mainTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70),
            mainTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70)
        ])
    }
    
    private func setupInputTeamName() {
        view.addSubview(teamNameField)
        teamNameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            teamNameField.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10),
            teamNameField.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            teamNameField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10)
        ])
    }
    
    private func setupCreateTeamButton() {
        view.addSubview(createTeamButton)
        createTeamButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createTeamButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10),
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
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            settingsButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
        ])
        settingsButton.addTarget(self, action: #selector(settingsDidTouch), for: .touchUpInside)
    }
    
    private func setupLeaveButton() {
        view.addSubview(leaveButton)
        leaveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leaveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            leaveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10)
        ])
        leaveButton.addTarget(self, action: #selector(wantToLeaveRoom), for: .touchUpInside)
    }
    
    // MARK: - Action targets
    
    @objc
    private func pauseRound(_ sender: AnyObject) {
        output.wantToPauseRound()
    }
    
    @objc
    private func startRound(_ sender: AnyObject) {
        if (dataSource.count < 2){
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
        output.wantToStartRound()
    }
    
    @objc
    private func wantToLeaveRoom(_ sender: AnyObject) {
        output.leaveRoom()
    }
    
    @objc
    private func createTeam(_ sender: AnyObject) {
        guard let name = teamNameField.text,
              !name.isEmpty
        else {
            return
        }
        teamNameField.text = ""
        output.createTeam(with: name)
    }
    
    @objc
    private func settingsDidTouch(_ sender: AnyObject) {
        output.changeSettings()
    }
    
    private func updateParticipants(){
        dataSource.removeAll()
        participants.removeAll()
        // TODO add in dataSource list of groups and add in participants all participants
        
        // dataSource = list of groups
        // participants = list of TeamPlayer
        
        tableView.reloadData()
    }
    
    private func handleDelete(indexPath: IndexPath) {
        // if (isAdmin) {
            
            // TODo delete team with index indexPath.row
            
            dataSource.remove(at: indexPath.row)
            tableView.reloadData()
       // }
    }
}

// MARK: - GameViewInput

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
    
    func presentSettings(output: SettingsViewOutput) {
        DispatchQueue.main.async { [weak self] in
            let settingsVC = SettingsViewController(isAdmin: true, output: output)
            output.setupView(vc: settingsVC)
            self?.present(settingsVC, animated: true)
        }
    }
    
    func updateAfterAddingTeam() {
        output.refreshTeams()
    }
    
    func leaveRoom() {
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func updateRound(state: String) {
        DispatchQueue.main.async { [weak self] in
            self?.infoLabel.text = state
            self?.pauseRoundButton.isEnabled.toggle()
            self?.startRoundButton.isEnabled.toggle()
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

// MARK: - UITableViewDataSource

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

// MARK: - UITableViewDelegate

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
