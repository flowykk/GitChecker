//
//  MainBuilder.swift
//  GitChecker
//
//  Created by Данила Рахманов on 23.04.2024.
//

import UIKit

final class FollowersBuilder {
    static func build(for user: User) -> FollowersViewController {
        let viewController = FollowersViewController()
        let router = FollowersRouter(view: viewController)
        let presenter = FollowersPresenter(view: viewController, router: router)
        
        viewController.presenter = presenter
        viewController.user = user
        
        return viewController
    }
}
