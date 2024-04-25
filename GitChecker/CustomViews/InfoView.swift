//
//  InfoView.swift
//  GitChecker
//
//  Created by Данила Рахманов on 24.04.2024.
//

import UIKit

final class InfoView: UIView {
    private let labelView: UIView = UIView()
    private let imageView: UIImageView = UIImageView()
    private let textLabel: UILabel = UILabel()
    private let countLabel: UILabel = UILabel()
    
    var imageName: String = String()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(imageName: String, text: String, count: Int) {
        super.init(frame: .zero)
        
        self.imageName = imageName
        textLabel.text = text
        countLabel.text = String(count)
        
        configureUI()
    }
}

extension InfoView {
    func configureUI() {
        configureImage()
        configureLabel()
        configureLabelView()
        configureCount()
    }
    
    private func configureLabelView() {
        labelView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(labelView)
        labelView.setHeight(30)
        labelView.pinTop(to: topAnchor, 15)
        labelView.pinCenterX(to: centerXAnchor)
                
        let imageSize = imageView.image?.size
        let titleSize = textLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        labelView.setWidth(5 + 5 + titleSize.width + imageSize!.width + 5)
    }
    
    private func configureImage() {
        let font = UIFont.systemFont(ofSize: 16, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: font)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        imageView.tintColor = .systemGray
        imageView.image = image
        
        labelView.addSubview(imageView)
        imageView.pinLeft(to: labelView.leadingAnchor, 5)
        imageView.pinCenterY(to: labelView.centerYAnchor)
    }
    
    private func configureLabel() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .systemGray
        textLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        labelView.addSubview(textLabel)
        textLabel.pinLeft(to: imageView.trailingAnchor, 5)
        textLabel.pinCenterY(to: labelView.centerYAnchor)
    }
    
    private func configureCount() {
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.textColor = .systemGray
        countLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        addSubview(countLabel)
        countLabel.pinTop(to: labelView.bottomAnchor, 10)
        countLabel.pinCenterX(to: centerXAnchor)
    }
}
