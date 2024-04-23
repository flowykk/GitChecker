//
//  MainPresenter.swift
//  GitChecker
//
//  Created by Данила Рахманов on 23.04.2024.
//

import UIKit

final class MainPresenter {
    private weak var view: MainViewController?
    private var router: MainRouter
    
    init(view: MainViewController?, router: MainRouter) {
        self.view = view
        self.router = router
    }
    
    func SearchFollowers(for username: String) {
        NetworkService.shared.getFollowers(for: username, page: 1) { (followers, errorMessage) in
            guard let followers = followers else {
                print(errorMessage)
                return
            }
            
            print(followers)
            print(followers.count)
        }
    }
}
