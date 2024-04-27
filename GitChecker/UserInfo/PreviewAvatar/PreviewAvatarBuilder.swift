//
//  PreviewAvatarBuilder.swift
//  GitChecker
//
//  Created by Данила Рахманов on 27.04.2024.
//

import UIKit

final class PreviewAvatarBuilder {
    static func build(with image: UIImage) -> PreviewAvatarViewController {
        let viewController = PreviewAvatarViewController()
        let router = PreviewAvatarRouter(view: viewController)
        let presenter = PreviewAvatarPresenter(view: viewController, router: router)
        
        viewController.presenter = presenter
        viewController.avatarImage = image
        
        return viewController
    }
}
