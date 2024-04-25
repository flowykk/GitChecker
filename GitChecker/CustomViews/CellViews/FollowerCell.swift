//
//  FollowerCell.swift
//  GitChecker
//
//  Created by Данила Рахманов on 23.04.2024.
//

import UIKit

final class FollowerCell: UICollectionViewCell {
    static let reuseID = "FollowerCell"
    var avatarImage: UIImageView = UIImageView()
    let usernameLabel: UILabel = UILabel()
    
    let cache = NetworkService.shared.cache
    
    private let accentColor = UIColor(named: "AccentColor")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        downloadImage(from: follower.avatarUrl)
    }
}

extension FollowerCell {
    private func configureCell() {
        configureAvatarImage()
        configureUsernameLabel()
    }
    
    private func configureAvatarImage() {
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.image = UIImage(systemName: "person.fill")
        avatarImage.clipsToBounds = true
        avatarImage.layer.cornerRadius = 20
        
        contentView.addSubview(avatarImage)
        let padding: CGFloat = 5
        avatarImage.setHeight(contentView.frame.width - padding * 2)
        avatarImage.setWidth(contentView.frame.width - padding * 2)
        avatarImage.pinTop(to: contentView.topAnchor, padding)
        avatarImage.pinLeft(to: contentView.leadingAnchor, padding)
    }
    
    private func configureUsernameLabel() {
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.textColor = accentColor
        usernameLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        usernameLabel.textAlignment = .center
        
        contentView.addSubview(usernameLabel)
        let padding: CGFloat = 5
        usernameLabel.pinTop(to: avatarImage.bottomAnchor, padding)
        usernameLabel.pinCenterX(to: contentView.centerXAnchor)
    }
    
    func downloadImage(from urlString: String) {
        if let image = cache.object(forKey: NSString(string: urlString)) {
            self.avatarImage.image = image
            return
        }
        
        NetworkService.shared.getImage(from: urlString) { [weak self] (image, errorMessage) in
            guard let self = self else { return }
            
            guard let image = image else {
                print(errorMessage!)
                return
            }
            
            DispatchQueue.main.async {
                self.avatarImage.image = image
            }
        }
    }
}
