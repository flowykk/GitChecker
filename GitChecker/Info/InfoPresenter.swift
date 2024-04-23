//
//  InfoPresenter.swift
//  GitChecker
//
//  Created by Данила Рахманов on 20.04.2024.
//

import Foundation

final class InfoPresenter {
    private weak var view: InfoViewController?
    
    init(view: InfoViewController?) {
        self.view = view
    }
}
