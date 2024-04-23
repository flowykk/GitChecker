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
    
    func StartButtonTapped() {
        router.navigateToMain()
    }
    
    func InfoButtonTapped() {
        router.presentInfo()
    }
}
