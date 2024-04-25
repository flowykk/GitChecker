//
//  WelcomeRouter.swift
//  GitChecker
//
//  Created by Данила Рахманов on 09.04.2024.
//

import UIKit

final class WelcomeRouter {
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func navigateToMain(for user: User) {
        let vc = FollowersBuilder.build(for: user)
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentInfo() {
        let vc = InfoBuilder.build()
        vc.modalPresentationStyle = .custom
        if let nc = view?.navigationController {
            vc.viewDistanceTop = nc.navigationBar.frame.height + 10
        }
        vc.welcomeVC = view as? WelcomeViewController
        view?.present(vc, animated: true)
    }
}
