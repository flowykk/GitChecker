//
//  UserInfoViewController.swift
//  GitChecker
//
//  Created by Данила Рахманов on 24.04.2024.
//

import UIKit

final class UserInfoViewController: UIViewController {
    var presenter: UserInfoPresenter?
    var mainUserAvatarUrl: String!
    var user: User!
    
    private let backButton: UIButton            = UIButton()
    private let imageView: UIImageView          = UIImageView()
    private let favouriteButton: UIButton = UIButton()
    
    private let avatarImage: UIImageView        = UIImageView()
    private let loginLabel: UILabel             = UILabel()
    private let nameLabel: UILabel              = UILabel()
    
    private var locationView: ImageLabelView    = ImageLabelView()
    private let descriptionLabel: UILabel       = UILabel()
    
    private let profileInfoView: UIView         = UIView()
    private var repositoriesView: InfoView      = InfoView()
    private var gistsView: InfoView             = InfoView()
    private let goToProfileButton: UIButton     = UIButton()
    
    private let followersInfoView: UIView       = UIView()
    private var followersView: InfoView         = InfoView()
    private var followingView: InfoView         = InfoView()
    private let viewFollowersButton: UIButton   = UIButton()
    
    private let registeredAtDate: UILabel       = UILabel()
    
    private let accentColor                     = UIColor(named: "AccentColor")
    private let backgroundColor                 = UIColor(named: "BackgroundColor")
    
    var isFavourite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        
        configureUI()
    }
    
    @objc
    private func backButtonTapped() {
        presenter?.backButtonTapped()
    }
    
    @objc
    private func goToProfileButtonTapped() {
        presenter?.goToProfileButtonTapped(from: user.htmlUrl)
    }
    
    @objc
    private func viewFollowersButtonTapped() {
        presenter?.viewFollowersButtonTapped(for: user.login)
    }
    
    @objc
    private func favouriteButtonTapped() {
        isFavourite.toggle()
        favouriteButton.setImage(FavouriteImage(), for: .normal)
    }
    
    @objc
    private func avatarTapped() {
        presenter?.gotToAvatarPreview(with: avatarImage.image!)
    }
    
    private func FavouriteImage() -> UIImage{
        let largeFont = UIFont.systemFont(ofSize: 22, weight: .medium)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        
        var image: UIImage = UIImage()
        if isFavourite {
            image = UIImage(systemName: "star.fill", withConfiguration: configuration)!
        } else {
            image = UIImage(systemName: "star", withConfiguration: configuration)!
        }
        
        return image
    }
}

extension UserInfoViewController {
    // MARK: - configuring UI method
    private func configureUI() {
        configureNavigationBar()
        configureFavouriteButton()
        configureBackButton()
        NetworkService.shared.downloadImage(from: user.avatarUrl, for: avatarImage)
        
        configureAvatarImage()
        configureTapGestureForAvatar()
        configureLoginLabel()
        configureNameLabel()
        
        configureLocationView()
        configureDescriptionLabel()
        
        configureProfileInfoView()
        configureRepositoriesView()
        configureGistsView()
        configureGoToProfileButton()
        
        configureFollowersInfoView()
        configureFollowersView()
        configureFollowingView()
        configureViewFollowersButton()
        
        configureRegisteredAtDate()
    }
    
    // MARK: - configuring NavigationBar
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favouriteButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    // MARK: - configuring Back To Followers Button
    private func configureBackButton() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let largeFont = UIFont.systemFont(ofSize: 22, weight: .medium)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "chevron.left", withConfiguration: configuration)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.addSubview(imageView)
        imageView.pinCenterY(to: backButton.centerYAnchor)
        
        let userImageView = UIImageView()
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.contentMode = .scaleAspectFill
        userImageView.clipsToBounds = true
        NetworkService.shared.downloadImage(from: mainUserAvatarUrl, for: userImageView)
        
        userImageView.layer.cornerRadius = 15
        
        backButton.addSubview(userImageView)
        userImageView.setWidth(30)
        userImageView.setHeight(30)
        userImageView.pinLeft(to: imageView.trailingAnchor, 5)
        userImageView.pinCenterY(to: backButton.centerYAnchor)
        
        let buttonWidth = imageView.frame.width + 30 + 5
        backButton.setWidth(buttonWidth)
    }
    
    private func configureFavouriteButton() {
        favouriteButton.setImage(FavouriteImage(), for: .normal)
        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - configuring Avatar Image
    private func configureAvatarImage() {
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.contentMode = .scaleAspectFill
        avatarImage.clipsToBounds = true
        
        let width = UIScreen.main.bounds.width / 3
        avatarImage.layer.cornerRadius = width / 2
        
        view.addSubview(avatarImage)
        avatarImage.setWidth(width)
        avatarImage.setHeight(width)
        avatarImage.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 5)
        avatarImage.pinCenterX(to: view.centerXAnchor)
    }
    
    // MARK: - configuring Login Label
    private func configureLoginLabel() {
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.text = user.login
        loginLabel.textColor = accentColor //.secondaryLabel
        loginLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        view.addSubview(loginLabel)
        loginLabel.pinTop(to: avatarImage.bottomAnchor, 6)
        loginLabel.pinCenterX(to: view.centerXAnchor)
    }
    
    // MARK: - configuring Name Label
    private func configureNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = user.name
        nameLabel.textColor = .secondaryLabel
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        view.addSubview(nameLabel)
        nameLabel.pinTop(to: loginLabel.bottomAnchor, 1)
        nameLabel.pinCenterX(to: view.centerXAnchor)
    }
    
    // MARK: - configuring Location View
    private func configureLocationView() {
        locationView = ImageLabelView(
            imageName: "location.fill",
            labelText: (user.location != nil ? user.location : "No location")!
        )
        locationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(locationView)
        locationView.setHeight(30)
        locationView.pinTop(to: nameLabel.bottomAnchor, -2)
        locationView.pinCenterX(to: view.centerXAnchor)
    }
    
    // MARK: - configuring Profile Description Label
    private func configureDescriptionLabel() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = user.bio
        descriptionLabel.textColor = .systemGray
        descriptionLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        descriptionLabel.textAlignment = .justified
        descriptionLabel.numberOfLines = 3
        
        view.addSubview(descriptionLabel)
        descriptionLabel.pinTop(to: locationView.bottomAnchor, 20)
        descriptionLabel.pinLeft(to: view.leadingAnchor, 10)
        descriptionLabel.pinRight(to: view.trailingAnchor, 10)
    }
    
    // MARK: - configuring Profile Info Section View
    private func configureProfileInfoView() {
        profileInfoView.translatesAutoresizingMaskIntoConstraints = false
        profileInfoView.backgroundColor = .systemGray6
        profileInfoView.layer.cornerRadius = 20
        
        view.addSubview(profileInfoView)
        profileInfoView.setHeight(150)
        profileInfoView.pinLeft(to: view, 10)
        profileInfoView.pinRight(to: view, 10)
        profileInfoView.pinTop(to: descriptionLabel.bottomAnchor, 5)
        profileInfoView.pinCenterX(to: view.centerXAnchor)
    }
    
    // MARK: - configuring Public Repositories View
    private func configureRepositoriesView() {
        repositoriesView = InfoView(imageName: "folder", text: "Public Repos", count: user.publicRepos)
        repositoriesView.translatesAutoresizingMaskIntoConstraints = false
        
        let width = (view.frame.width - 10 * 2) / 2

        profileInfoView.addSubview(repositoriesView)
        repositoriesView.pinHeight(to: profileInfoView)
        repositoriesView.setWidth(width)
        repositoriesView.pinLeft(to: profileInfoView)
        repositoriesView.pinTop(to: profileInfoView)
    }
    
    // MARK: - configuring Gists View
    private func configureGistsView() {
        gistsView = InfoView(imageName: "book.pages", text: "Public Gists", count: user.publicGists)
        gistsView.translatesAutoresizingMaskIntoConstraints = false
        
        let width = (view.frame.width - 10 * 2) / 2
        
        profileInfoView.addSubview(gistsView)
        gistsView.pinHeight(to: profileInfoView)
        gistsView.setWidth(width)
        gistsView.pinRight(to: profileInfoView)
        gistsView.pinTop(to: profileInfoView)
    }
    
    // MARK: - configuring GoToProfile Button
    private func configureGoToProfileButton() {
        goToProfileButton.setTitle("Go to profile", for: .normal)
        goToProfileButton.setTitleColor(backgroundColor, for: .normal)
        goToProfileButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        goToProfileButton.backgroundColor = accentColor
        goToProfileButton.layer.cornerRadius = 15
        
        goToProfileButton.addTarget(self, action: #selector(goToProfileButtonTapped), for: .touchUpInside)
        
        profileInfoView.addSubview(goToProfileButton)
        goToProfileButton.setHeight(50)
        goToProfileButton.pinLeft(to: profileInfoView, 10)
        goToProfileButton.pinRight(to: profileInfoView, 10)
        goToProfileButton.pinBottom(to: profileInfoView, 10)
    }
    
    // MARK: - configuring FollowersInfo View
    private func configureFollowersInfoView() {
        followersInfoView.translatesAutoresizingMaskIntoConstraints = false
        followersInfoView.backgroundColor = .systemGray6
        followersInfoView.layer.cornerRadius = 20
        
        view.addSubview(followersInfoView)
        followersInfoView.setHeight(150)
        followersInfoView.pinLeft(to: view, 10)
        followersInfoView.pinRight(to: view, 10)
        followersInfoView.pinTop(to: profileInfoView.bottomAnchor, 10)
        followersInfoView.pinCenterX(to: view.centerXAnchor)
    }
    
    // MARK: - configuring Public Repositories View
    private func configureFollowersView() {
        followersView = InfoView(imageName: "person.2", text: "Followers", count: user.followers)
        followersView.translatesAutoresizingMaskIntoConstraints = false
        
        let width = (view.frame.width - 10 * 2) / 2

        followersInfoView.addSubview(followersView)
        followersView.pinHeight(to: followersInfoView)
        followersView.setWidth(width)
        followersView.pinLeft(to: followersInfoView)
        followersView.pinTop(to: followersInfoView)
    }
    
    // MARK: - configuring Gists View
    private func configureFollowingView() {
        followingView = InfoView(imageName: "heart", text: "Following", count: user.following)
        followingView.translatesAutoresizingMaskIntoConstraints = false
        
        let width = (view.frame.width - 10 * 2) / 2
        
        followersInfoView.addSubview(followingView)
        followingView.pinHeight(to: followersInfoView)
        followingView.setWidth(width)
        followingView.pinRight(to: followersInfoView)
        followingView.pinTop(to: followersInfoView)
    }
    
    // MARK: - configuring ViewFollowers Button
    private func configureViewFollowersButton() {
        viewFollowersButton.setTitle("View Followers", for: .normal)
        viewFollowersButton.setTitleColor(backgroundColor, for: .normal)
        viewFollowersButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        viewFollowersButton.backgroundColor = .systemGreen
        viewFollowersButton.layer.cornerRadius = 15
        
        viewFollowersButton.addTarget(self, action: #selector(viewFollowersButtonTapped), for: .touchUpInside)
        
        followersInfoView.addSubview(viewFollowersButton)
        viewFollowersButton.setHeight(50)
        viewFollowersButton.pinLeft(to: followersInfoView, 10)
        viewFollowersButton.pinRight(to: followersInfoView, 10)
        viewFollowersButton.pinBottom(to: followersInfoView, 10)
    }
    
    // MARK: - configuring RegisteredAt Date
    private func configureRegisteredAtDate() {
        let registeredDate = user.createdAt.convertToDisplayFormat()
        registeredAtDate.translatesAutoresizingMaskIntoConstraints = false
        registeredAtDate.text = "Profile created at \(registeredDate)"
        registeredAtDate.textColor = .secondaryLabel
        registeredAtDate.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        view.addSubview(registeredAtDate)
        registeredAtDate.pinTop(to: followersInfoView.bottomAnchor, 15)
        registeredAtDate.pinCenterX(to: view.centerXAnchor)
    }
    
    // MARK: - configuring tap gesture for AvatarImage
    private func configureTapGestureForAvatar() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        avatarImage.addGestureRecognizer(tap)
        avatarImage.isUserInteractionEnabled = true
    }
}
