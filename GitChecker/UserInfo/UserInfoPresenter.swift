//
//  UserInfoPresenter.swift
//  GitChecker
//
//  Created by Данила Рахманов on 24.04.2024.
//

import UIKit

final class UserInfoPresenter {
    private weak var view: UserInfoViewController?
    private var router: UserInfoRouter
    
    init(view: UserInfoViewController?, router: UserInfoRouter) {
        self.view = view
        self.router = router
    }
    
    func backButtonTapped() {
        router.navigateBack()
    }
    
    func goToProfileButtonTapped(from url: String) {
        router.navigateToProfile(from: url)
    }
    
    func viewFollowersButtonTapped(for username: String) {
        NetworkService.shared.getUser(by: username) { [weak self] (user, errorMessage) in
            guard let self = self else { return }
            
            guard let user = user else {
                print(errorMessage!)
                return
            }
            
            DispatchQueue.main.async {
                self.router.navigateToFollowers(for: user)
            }
        }
    }
    
    func gotToAvatarPreview(with image: UIImage) {
        router.navigateToAvatarPreview(with: image)
    }
}
