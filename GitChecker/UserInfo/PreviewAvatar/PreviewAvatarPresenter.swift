//
//  PreviewAvatarPresenter.swift
//  GitChecker
//
//  Created by Данила Рахманов on 27.04.2024.
//

import UIKit

final class PreviewAvatarPresenter {
    private weak var view: PreviewAvatarViewController?
    private var router: PreviewAvatarRouter
    
    init(view: PreviewAvatarViewController?, router: PreviewAvatarRouter) {
        self.view = view
        self.router = router
    }
        
}
