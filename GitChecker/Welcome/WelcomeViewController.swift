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
    private let startButton: UIButton = UIButton()
    
    private let accentColor = UIColor(named: "AccentColor")
    private let backgroundColor = UIColor(named: "BackgroundColor")
    private let appLogo = UIImage(named: "AppIcon")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        
        configureUI()
    }
    
    @objc
    private func InfoButtonTapped() {
        presenter?.InfoButtonTapped()
    }
    
    @objc
    private func StartButtonTapped() {
        presenter?.StartButtonTapped()
    }
}

extension WelcomeViewController {
    private func configureUI() {
        configureAppNameLabel()
        configureAppDescLabel()
        configureAppLogo()
        configureAppInfoButton()
        configureStartButton()
    }
    
    private func configureAppNameLabel() {
        appName.translatesAutoresizingMaskIntoConstraints = false
        
        appName.text = "Welcome to"
        appName.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        appName.textColor = accentColor
        
        view.addSubview(appName)
        appName.pinTop(to: view.topAnchor, 100)
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
    
    private func configureAppLogo() {
        
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
        InfoButton.pinTop(to: view.topAnchor, 105)
        InfoButton.pinRight(to: view.trailingAnchor, 15)
        InfoButton.setWidth(40)
        InfoButton.setHeight(40)
    }
    
    private func configureStartButton() {
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        startButton.backgroundColor = accentColor
        startButton.setTitle("Start Viewing", for: .normal)
        startButton.setTitleColor(backgroundColor, for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        startButton.layer.cornerRadius = 30
        
        startButton.addTarget(self, action: #selector(StartButtonTapped), for: .touchUpInside)
        
        view.addSubview(startButton)
        startButton.pinBottom(to: view.bottomAnchor, 110)
        startButton.pinCenterX(to: view.centerXAnchor)
        startButton.setHeight(60)
        startButton.setWidth(250)
    }
}

