//
//  CreateRoomViewController.swift
//  Alias
//
//  Created by Kate on 20.05.2023.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController{
    
    private var contentView: UIView = UIView()
    
    // var delegate: DeletingRoom = GameViewController(roomId: "", name: "", isAdmin: false)
    
    private lazy var adminView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var participantView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()


    private lazy var roomNameInput = { () -> UITextField in
        let input = UITextField()
        input.placeholder = "Room Name"
        input.borderStyle = .roundedRect
        input.autocapitalizationType = .none
        input.textColor = .black
        return input
    }()

    private lazy var pointsInput = { () -> UITextField in
        let input = UITextField()
        input.placeholder = "Number of points"
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

    private lazy var applyButton = { () -> UIButton in
        let button = UIButton()
        button.setTitle("Apply changes", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    private lazy var deleteButton = { () -> UIButton in
        let button = UIButton()
        button.setTitle("Delete room", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    private var isAdmin: Bool = true
    
    init (isAdmin: Bool){
        self.isAdmin = isAdmin
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if (isAdmin){
            self.contentView = self.adminView
        }
        else{
            self.contentView = self.participantView
        }
        setupView()
    }
    
    
    private func setupView() {
        setupContentView()
        setupNameInput()
        setupApplyButton()
        setupPrivateToggle()
        setupPointsInput()
        setupDeleteButton()
    }
    
    private func setupDeleteButton() {
        contentView.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            deleteButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)
        ])
        deleteButton.addTarget(self, action: #selector(deleteRoom), for: .touchUpInside)
    }
    
    private func setupContentView() {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        ])
    }
    
    private func setupNameInput() {
        contentView.addSubview(roomNameInput)
        roomNameInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            roomNameInput.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            roomNameInput.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            roomNameInput.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40)
        ])
    }
    
    private func setupPointsInput() {
        contentView.addSubview(pointsInput)
        pointsInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pointsInput.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            pointsInput.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            pointsInput.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100)
        ])
    }

    private func setupPrivateToggle() {
        contentView.addSubview(isPrivteToggle)
        isPrivteToggle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            isPrivteToggle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            isPrivteToggle.rightAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -5),
            isPrivteToggle.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 70)
        ])
        
        contentView.addSubview(toggleLabel)
        toggleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toggleLabel.leftAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 5),
            toggleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            toggleLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 70)
        ])
    }
    
    private func setupApplyButton() {
        contentView.addSubview(applyButton)
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            applyButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            applyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -70),
            applyButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)
        ])
        applyButton.addTarget(self, action: #selector(applyChanges), for: .touchUpInside)
    }
    
    
    
    @objc
    private func applyChanges(_ sender: AnyObject) {
        // ToDo change settings
    }
    
    @objc
    private func deleteRoom(_ sender: AnyObject) {
        // ToDo delete room
        
        // delegate.deleteRoom()
        self.dismiss(animated: true)
//        var controllers = self.navigationController?.viewControllers
//
//        for vc in controllers!{
//            if (vc is JoinRoomViewController){
//                self.navigationController?.popToViewController(vc, animated: true)
//            }
//        }
    }
    
    
}
