//
//  CreateRoomViewController.swift
//  Alias
//
//  Created by Kate on 20.05.2023.
//

import Foundation
import UIKit

class GameViewController: UIViewController{
    
    
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
    
    init (roomId: String, name: String){
        self.roomId = roomId
        self.name = name
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
        view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
        
        present(SettingsViewController(isAdmin: true), animated: true)
    }
    
    
    
    
}
