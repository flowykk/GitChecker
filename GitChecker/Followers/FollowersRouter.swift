//
//  MainRouter.swift
//  GitChecker
//
//  Created by Данила Рахманов on 23.04.2024.
//

import UIKit

final class FollowersRouter {
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func navigateToUserInfo(for user: User, by mainUser: User) {
        let vc = UserInfoBuilder.build(for: user, by: mainUser)
        view?.navigationController?.pushViewController(vc, animated: true)
    }
}
