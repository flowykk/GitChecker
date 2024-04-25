//
//  ImageLabelView.swift
//  GitChecker
//
//  Created by Данила Рахманов on 25.04.2024.
//

import UIKit

final class ImageLabelView: UIView {
    private let label: UILabel = UILabel()
    private let imageView: UIImageView = UIImageView()
    
    var imageName: String = String()
    var labelText: String = String()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(imageName: String, labelText: String) {
        super.init(frame: .zero)
        
        self.imageName = imageName
        self.labelText = labelText
        
        configureUI()
    }
}

extension ImageLabelView {
    private func configureUI() {
        configureImage()
        configureLabel()
        configureView()
    }
    
    // MARK: - configuring Location Arrow Image
    private func configureImage() {
        let font = UIFont.systemFont(ofSize: 13, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: font)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        imageView.tintColor = .tertiaryLabel
        imageView.image = image
        
        addSubview(imageView)
        imageView.pinLeft(to: leadingAnchor, 5)
        imageView.pinCenterY(to: centerYAnchor)
    }
    
    // MARK: - configuring Location Label
    private func configureLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = labelText
        label.textColor = .tertiaryLabel
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        
        addSubview(label)
        label.pinLeft(to: imageView.trailingAnchor, 5)
        label.pinCenterY(to: centerYAnchor)
    }
    
    private func configureView() {
        let imageSize = imageView.image?.size
        let titleSize = label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        setWidth(5 + 5 + titleSize.width + imageSize!.width + 5)
    }
}
