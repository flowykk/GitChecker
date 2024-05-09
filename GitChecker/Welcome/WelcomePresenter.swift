//
//  WelcomePresenter.swift
//  GitChecker
//
//  Created by Данила Рахманов on 09.04.2024.
//

import UIKit

final class WelcomePresenter {
    private weak var view: WelcomeViewController?
    private var router: WelcomeRouter
    
    init(view: WelcomeViewController?, router: WelcomeRouter) {
        self.view = view
        self.router = router
    }
    
    func favouriteTapped(by follower: Follower) {
        NetworkService.shared.getUser(by: follower.login) { [weak self] (user, errorMessage) in
            guard let self = self else { return }
            
            guard let user = user else {
                print(errorMessage!)
                return
            }
            
            DispatchQueue.main.async {
                self.router.navigateToUserInfo(for: user)
            }
        }
    }
    
    func infoButtonTapped() {
        router.presentInfo()
    }
    
    func searchFollowers(for username: String) {
        NetworkService.shared.getUser(by: username) { [weak self] (user, errorMessage) in
            guard let self = self else { return }
            
            guard let user = user else {
                print(errorMessage!)
                return
            }
            
            DispatchQueue.main.async {
                self.router.navigateToMain(for: user)
            }
        }
    }
}
