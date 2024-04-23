//
//  InfoBuilder.swift
//  GitChecker
//
//  Created by Данила Рахманов on 09.04.2024.
//

import UIKit

final class InfoBuilder {
    static func build() -> InfoViewController {
        let viewController = InfoViewController()
        let presenter = InfoPresenter(view: viewController)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
