//
//  UserInfoBuilder.swift
//  GitChecker
//
//  Created by Данила Рахманов on 24.04.2024.
//

import UIKit

final class UserInfoBuilder {
    static func build(for user: User, by mainUser: User?) -> UserInfoViewController {
        let viewController = UserInfoViewController()
        let router = UserInfoRouter(view: viewController)
        let presenter = UserInfoPresenter(view: viewController, router: router)
        
        viewController.presenter = presenter
        viewController.user = user
        viewController.mainUserAvatarUrl = mainUser?.avatarUrl
        
        return viewController
    }
}
