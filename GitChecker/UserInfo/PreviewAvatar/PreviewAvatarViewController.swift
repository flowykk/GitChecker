//
//  PreviewAvatarViewController.swift
//  GitChecker
//
//  Created by Данила Рахманов on 27.04.2024.
//

import UIKit

final class PreviewAvatarViewController: UIViewController {
    var presenter: PreviewAvatarPresenter?
    var avatarImage: UIImage!
    
    private let avatarImageView: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        
        configureUI()
    }
    
    @objc
    private func handleTapOutsideImage(sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        if !avatarImageView.frame.contains(location) {
            dismiss(animated: true, completion: nil)
        }
    }
}

extension PreviewAvatarViewController {
    private func configureUI() {
        configureTapGesture()
        configureBlurEffect()
        
        configureAvatarImageView()
    }
    
    private func configureAvatarImageView() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.image = avatarImage
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        
        let size = view.frame.width / 2 + 50
        avatarImageView.layer.cornerRadius = size / 2
        
        view.addSubview(avatarImageView)
        avatarImageView.setWidth(size)
        avatarImageView.setHeight(size)
        avatarImageView.pinCenter(to: view)
    }
    
    private func configureBlurEffect() {
        let blurEffect = UIBlurEffect(style: .systemMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = view.bounds
        view.addSubview(blurEffectView)
        view.sendSubviewToBack(blurEffectView)
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideImage))
        view.addGestureRecognizer(tapGesture)
    }
}
