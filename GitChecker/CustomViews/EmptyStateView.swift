//
//  EmptyStateView.swift
//  GitChecker
//
//  Created by Данила Рахманов on 24.04.2024.
//

import UIKit

final class EmptyStateView: UIView {
    let messageLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configureUI()
    }
}

extension EmptyStateView {
    func configureUI() {
        configureMessageLabel()
    }
    
    func configureMessageLabel() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        //messageLabel.text = "No Followers yet 😨"
        messageLabel.textColor = .secondaryLabel
        
        addSubview(messageLabel)
        messageLabel.pinCenterX(to: centerXAnchor)
        messageLabel.pinCenterY(to: centerYAnchor)
    }
}
