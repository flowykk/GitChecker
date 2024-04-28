//
//  UserInfoRouter.swift
//  GitChecker
//
//  Created by Данила Рахманов on 24.04.2024.
//

import UIKit
import SafariServices

final class UserInfoRouter {
    private weak var view: UIViewController?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func navigateBack() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToProfile(from profileUrl: String) {
        guard let url = URL(string: profileUrl) else {
            print("error")
            return
        }
        
        let safari = SFSafariViewController(url: url)
        view?.present(safari, animated: true)
    }
    
    func navigateToFollowers(for user: User) {
        let vc = FollowersBuilder.build(for: user)
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToAvatarPreview(with image: UIImage) {
        let vc = PreviewAvatarBuilder.build(with: image)
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        view?.present(vc, animated: true)
    }
}
