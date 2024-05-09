//
//  FavouriteCell.swift
//  GitChecker
//
//  Created by Данила Рахманов on 05.05.2024.
//

import UIKit

final class FavouriteCell: UITableViewCell {
    private var avatarImageView: UIImageView = UIImageView()
    private var usernameLabel: UILabel = UILabel()
    private let chevronImageView: UIImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let left = 12 + UIScreen.main.bounds.width * 0.09 + 12
        separatorInset = UIEdgeInsets(top: .zero, left: CGFloat(left), bottom: .zero, right: .zero)
    }
    
    func set(follower: Follower) {
        NetworkService.shared.downloadImage(from: follower.avatarUrl, for: avatarImageView)
        usernameLabel.text = follower.login
    }
}

extension FavouriteCell {
    private func configureUI() {
        backgroundColor = .systemGray6
        selectionStyle = .none
        
        configureUserAvatar()
        configureUserName()
        configureChevronImageView()
    }
    
    private func configureUserAvatar() {
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        
        let size = UIScreen.main.bounds.width * 0.09
        avatarImageView.layer.cornerRadius = size / 2
        
        addSubview(avatarImageView)
        avatarImageView.setWidth(size)
        avatarImageView.setHeight(size)
        avatarImageView.pinLeft(to: leadingAnchor, 12)
        avatarImageView.pinCenterY(to: centerYAnchor)
    }
    
    private func configureUserName() {
        usernameLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        
        addSubview(usernameLabel)
        usernameLabel.pinLeft(to: avatarImageView.trailingAnchor, 10)
        usernameLabel.pinCenterY(to: centerYAnchor)
    }
    
    private func configureChevronImageView() {
        chevronImageView.tintColor = .systemGray
        
        addSubview(chevronImageView)
        chevronImageView.contentMode = .scaleAspectFit
        let largeFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "chevron.right", withConfiguration: configuration)
        chevronImageView.image = image
        
        chevronImageView.pinRight(to: trailingAnchor, 12)
        chevronImageView.pinCenterY(to: centerYAnchor)
    }
}
