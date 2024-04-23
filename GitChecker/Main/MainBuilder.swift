//
//  MainBuilder.swift
//  GitChecker
//
//  Created by Данила Рахманов on 23.04.2024.
//

import UIKit

final class MainBuilder {
    static func build() -> MainViewController {
        let viewController = MainViewController()
        let router = MainRouter(view: viewController)
        let presenter = MainPresenter(view: viewController, router: router)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
