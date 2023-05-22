

import UIKit


final class ParticipantsCell: UITableViewCell {
    
    static let reuseIdentifier = "ParticipantsCell"
    private var users: [TeamPlayer]
    let scrollView = UIScrollView()
    let content = UIStackView()
    var stacks:[UIStackView] = []
    
    
    
    
    private lazy var mainTitle = { () -> UILabel in
        let label = UILabel()
        label.text = "Participants"
        label.backgroundColor = .lightGray
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .regular)
        return label
    }()
    
    private lazy var deleteButton = { () -> UIButton in
        let button = UIButton()
        button.setImage(UIImage(
            systemName: "trash.fill",
            withConfiguration: UIImage.SymbolConfiguration(weight: .bold))?.withTintColor(.white), for: .normal)
        button.addTarget(self, action: #selector(deleteParticipant), for: .touchUpInside)
        return button
    }()
    
    private lazy var passAdminButton = { () -> UIButton in
        let button = UIButton()
        button.setTitle("Set admin", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(passAdminStatus), for: .touchUpInside)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        users = []
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
    
    private func getRandomColor() -> UIColor {
        return UIColor(red: CGFloat(Int.random(in: 0..<256)) / 255, green: CGFloat(Int.random(in: 0..<256)) / 255, blue: CGFloat(Int.random(in: 0..<256)) / 255, alpha: 0.5)
    }
    
    private func setupView() {
        contentView.backgroundColor = .clear
        content.backgroundColor = getRandomColor()
        content.axis = .vertical
        content.spacing = 5
        content.distribution = .fillEqually
        contentView.addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            content.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            content.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            content.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            content.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ])
        content.alignment = .fill
        
        
        
 }

    @objc
    private func passAdminStatus(_ sender: AnyObject) {
    
        
    }
    
    @objc
    private func deleteParticipant(_ sender: AnyObject) {
        // ToDo join user this team
    }

    
    func configure(usernames: [TeamPlayer]){
        users = usernames
        stacks = []
        for stack in content.subviews{
            stack.removeFromSuperview()
        }
        content.addArrangedSubview(mainTitle)
        for i in 0..<users.count{
            	
            let l = makeUserLabel(text: users[i].name)
            
            var stack = UIStackView(arrangedSubviews: [l, passAdminButton, deleteButton])
            stack.axis = .horizontal
            stacks.append(stack)
            content.addArrangedSubview(stacks.last!)
        }
    }
    
    private func makeUserLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
     }
    
}
