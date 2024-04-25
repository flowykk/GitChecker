//
//  ViewController.swift
//  GitChecker
//
//  Created by Данила Рахманов on 09.04.2024.
//

import UIKit

final class WelcomeViewController: UIViewController {
    var presenter: WelcomePresenter?
    
    private let appName: UILabel = UILabel()
    private let appDesc: UILabel = UILabel()
    private let InfoButton: UIButton = UIButton()
    
    private let searchField: UITextField = UITextField()
    private let searchButton: UIButton = UIButton()
        
    private let accentColor = UIColor(named: "AccentColor")
    private let backgroundColor = UIColor(named: "BackgroundColor")
    private let appLogo = UIImage(named: "AppIcon")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        view.backgroundColor = backgroundColor
        
        configureUI()
    }
    
    @objc
    private func InfoButtonTapped() {
        presenter?.InfoButtonTapped()
    }
    
    @objc
    private func SearchButtonTapped() {
        if !searchField.text!.isEmpty {
            presenter?.SearchFollowers(for: searchField.text!)
        }
    }
}

extension WelcomeViewController {
    private func configureUI() {
        configureAppNameLabel()
        configureAppDescLabel()
        configureAppInfoButton()
        configureSearchButton()
        configureSearchField()
    }
    
    private func configureAppNameLabel() {
        appName.translatesAutoresizingMaskIntoConstraints = false
        
        appName.text = "Welcome to"
        appName.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        appName.textColor = accentColor
        
        view.addSubview(appName)
        appName.pinTop(to: view.topAnchor, 70)
        appName.pinLeft(to: view.leadingAnchor, 20)
    }
    
    private func configureAppDescLabel() {
        appDesc.translatesAutoresizingMaskIntoConstraints = false
        
        appDesc.text = "Your Git Viewer"
        appDesc.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        appDesc.textColor = accentColor
        
        view.addSubview(appDesc)
        appDesc.pinTop(to: appName.bottomAnchor, -5)
        appDesc.pinLeft(to: view.leadingAnchor, 20)
    }
    
    private func configureAppInfoButton() {
        InfoButton.translatesAutoresizingMaskIntoConstraints = false

        let font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        let configuration = UIImage.SymbolConfiguration(font: font)
        let image = UIImage(systemName: "info.circle.fill", withConfiguration: configuration)
        InfoButton.setImage(image, for: .normal)
        
        InfoButton.tintColor = accentColor
        InfoButton.backgroundColor = .systemGray6
        InfoButton.layer.cornerRadius = 40 / 2
        
        InfoButton.addTarget(self, action: #selector(InfoButtonTapped), for: .touchUpInside)
        
        view.addSubview(InfoButton)
        InfoButton.pinTop(to: view.topAnchor, 75)
        InfoButton.pinRight(to: view.trailingAnchor, 15)
        InfoButton.setWidth(40)
        InfoButton.setHeight(40)
    }
    
    private func configureSearchField() {
        view.addSubview(searchField)
        searchField.translatesAutoresizingMaskIntoConstraints = false
        
        searchField.placeholder = "Search GitHub User"
        searchField.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
                
        let imageWidth = UIScreen.main.bounds.width * 0.09
        let leftViewWidth = 8 + imageWidth + 8
        
        let imageView: UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        
        let font = UIFont.systemFont(ofSize: 20, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: font)
        var image = UIImage(systemName: "magnifyingglass", withConfiguration: configuration)
        image = image?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        imageView.image = image
        
        imageView.setWidth(leftViewWidth)
        imageView.setHeight(50)
        
        searchField.leftView = imageView
        searchField.rightView = UIView(frame: CGRect(x: .zero, y: .zero, width: 20, height: 50))
        searchField.leftViewMode = .always
        searchField.rightViewMode = .always
        searchField.backgroundColor = .systemGray6
        searchField.layer.cornerRadius = 15
        
        searchField.setHeight(50)
        searchField.pinTop(to: appDesc.bottomAnchor, 40)
        searchField.pinLeft(to: view.leadingAnchor, 10)
        searchField.pinRight(to: searchButton.leadingAnchor, 10)
    }
    
    private func configureSearchButton() {
        view.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        searchButton.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        searchButton.imageView?.tintColor = backgroundColor
        searchButton.backgroundColor = accentColor
        searchButton.layer.cornerRadius = 13
        
        searchButton.imageView?.setWidth(24)
        searchButton.imageView?.setHeight(24)
    
        searchButton.addTarget(self, action: #selector(SearchButtonTapped), for: .touchUpInside)
        
        searchButton.setHeight(50)
        searchButton.setWidth(60)
        searchButton.pinTop(to: appDesc.bottomAnchor, 40)
        searchButton.pinRight(to: view.trailingAnchor, 10)
    }
}

