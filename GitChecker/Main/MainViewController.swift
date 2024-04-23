//
//  File.swift
//  GitChecker
//
//  Created by Данила Рахманов on 23.04.2024.
//

import UIKit

final class MainViewController: UIViewController {
    var presenter: MainPresenter?
    
    private let searchField: UITextField = UITextField()
    private let searchButton: UIButton = UIButton()
    
    private let accentColor = UIColor(named: "AccentColor")
    private let backgroundColor = UIColor(named: "BackgroundColor")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        
        configureUI()
    }
    
    @objc
    private func SearchButtonTapped() {
        presenter?.SearchFollowers(for: searchField.text ?? "")
    }
    
}

extension MainViewController {
    func configureUI() {
        configureNavigationBar()
        configureSearchButton()
        configureSearchField()
    }
    
    private func configureNavigationBar() {
        navigationItem.hidesBackButton = true
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
        searchField.layer.cornerRadius = 20
        
        searchField.setHeight(50)
        searchField.pinTop(to: view.topAnchor, 100)
        searchField.pinLeft(to: view.leadingAnchor, 10)
        searchField.pinRight(to: searchButton.leadingAnchor, 10)
    }
    
    private func configureSearchButton() {
        view.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        searchButton.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        searchButton.backgroundColor = .systemGray6
        searchButton.layer.cornerRadius = 13
        
        searchButton.imageView?.setWidth(24)
        searchButton.imageView?.setHeight(24)
    
        searchButton.addTarget(self, action: #selector(SearchButtonTapped), for: .touchUpInside)
        
        searchButton.setHeight(50)
        searchButton.setWidth(60)
        searchButton.pinTop(to: view.topAnchor, 100)
        searchButton.pinRight(to: view.trailingAnchor, 10)
    }
}
