//
//  RoomCell.swift
//  Alias
//
//  Created by Kate on 20.05.2023.
//

import UIKit
class RoomCell : UITableViewCell{
    
    static let reuseIdentifier = "RoomCell"
    private var roomId: String = " "
    private var roomName: String
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        roomName = ""
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var joinButton = { () -> UIButton in
        let button = UIButton()
        button.setTitle("Join", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    private lazy var nameLabel = { () -> UILabel in
        let label = UILabel()
        label.text = "Name"
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private func setupView() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, joinButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.backgroundColor = .lightGray
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 2),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -2)
        ])
    }
    
    func configure(room: Room){
        roomId = room.id
        roomName = room.name
        nameLabel.text = roomName
    }
}
