//
//  LoadingViewExtension.swift
//  GitChecker
//
//  Created by Данила Рахманов on 24.04.2024.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(activityIndicator)
        activityIndicator.pinCenterX(to: view.centerXAnchor)
        activityIndicator.pinCenterY(to: view.centerYAnchor)
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = EmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        
        view.addSubview(emptyStateView)
    }
}
