//
//  WelcomeBuilder.swift
//  GitChecker
//
//  Created by Данила Рахманов on 09.04.2024.
//

import UIKit

final class WelcomeBuilder {
    static func build() -> WelcomeViewController {
        let viewController = WelcomeViewController()
        let router = WelcomeRouter(view: viewController)
        let presenter = WelcomePresenter(view: viewController, router: router)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
