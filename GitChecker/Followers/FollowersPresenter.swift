//
//  MainPresenter.swift
//  GitChecker
//
//  Created by Данила Рахманов on 23.04.2024.
//

import UIKit

final class FollowersPresenter {
    private weak var view: FollowersViewController?
    private var router: FollowersRouter
    
    init(view: FollowersViewController?, router: FollowersRouter) {
        self.view = view
        self.router = router
    }
    
    func UserTapped(withName username: String, by mainUser: User) {
        NetworkService.shared.getUser(by: username) { [weak self] (user, errorMessage) in
            guard let self = self else { return }
            
            guard let user = user else {
                print(errorMessage!)
                return
            }
            
            DispatchQueue.main.async {
                self.router.navigateToUserInfo(for: user, by: mainUser)
            }
        }
    }
}
