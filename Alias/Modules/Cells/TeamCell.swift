

import UIKit


final class TeamCell: UITableViewCell {
    
    static let reuseIdentifier = "TeamCell"
    
    // MARK: - Private properties
    
    private var teamUsers: [TeamPlayer]
    private let scrollView = UIScrollView()
    private let content = UIStackView()
    private var labels:[UILabel] = []
    private var isTeam: Bool = true
    
    private lazy var joinButton = { () -> UIButton in
        let button = UIButton()
        button.setTitle("Join team", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    private lazy var mainTitle = { () -> UILabel in
        let label = UILabel()
        label.text = ""
        label.backgroundColor = .lightGray
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 40, weight: .regular)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        teamUsers = []
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
    
    func setIsTeam(isTeam: Bool){
        self.isTeam = isTeam
    }

    // MARK: - Confugure
    
    func configure(usernames: [TeamPlayer], title: String){
        teamUsers = usernames
        labels = []
        for label in content.subviews{
            label.removeFromSuperview()
        }
        mainTitle.text = title
        content.addArrangedSubview(mainTitle)
        for i in 0..<teamUsers.count{
            labels.append(makeUserLabel(text: teamUsers[i].name))
            content.addArrangedSubview(labels.last!)
        }
        if (isTeam){
            content.addArrangedSubview(joinButton)
        }
    }
    
    private func makeUserLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .regular)
        return label
     }
    
}
