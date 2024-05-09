//
//  MainViewController.swift
//  GitChecker
//
//  Created by Данила Рахманов on 23.04.2024.
//

import UIKit

final class FollowersViewController: UIViewController {
    var presenter: FollowersPresenter?
    
    enum Section {
        case main
    }
    
    var user: User!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    private var collectionView: UICollectionView!
    private let searchField: UISearchController = UISearchController()
    private let profileButton: UIButton = UIButton()
    
    private let titleView: UIView = UIView()
    
    private let accentColor = UIColor(named: "AccentColor")
    private let backgroundColor = UIColor(named: "BackgroundColor")

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        
        configureUI()
    }
    
    @objc
    private func profileButtonTapped() {
        presenter?.userTapped(withName: user.login, by: user)
    }
}

extension FollowersViewController {
    func configureUI() {
        configureTitleView()
        configureProfileButton()
        configureNavigationBar()
        configureSearchField()
        
        configureCollectionView()
        getFollowers(for: user.login, page: page)
        configureDataSource()
    }
    
    private func configureTitleView() {
        let userImageView = UIImageView()
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.contentMode = .scaleAspectFill
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = 15
        NetworkService.shared.downloadImage(from: user.avatarUrl, for: userImageView)
        
        titleView.addSubview(userImageView)
        userImageView.setWidth(30)
        userImageView.setHeight(30)
        userImageView.pinTop(to: titleView)
        userImageView.pinCenterY(to: titleView.centerYAnchor)
        
        let usernameLabel = UILabel()
        usernameLabel.text = user.login
        usernameLabel.textColor = accentColor
        usernameLabel.sizeToFit()
        usernameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        titleView.addSubview(usernameLabel)
        usernameLabel.pinTop(to: titleView)
        usernameLabel.pinLeft(to: userImageView.trailingAnchor, 5)
        usernameLabel.pinCenterY(to: titleView.centerYAnchor)
                
        let width = 30 + 5.0 + usernameLabel.frame.width
        titleView.setWidth(width)
        titleView.setHeight(30)
    }
    
    private func configureProfileButton() {
        let largeFont = UIFont.systemFont(ofSize: 24, weight: .medium)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "person.crop.circle", withConfiguration: configuration)
        profileButton.setImage(image, for: .normal)
        
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
    }
    
    private func configureSearchField() {
        searchField.searchResultsUpdater = self
        searchField.searchBar.placeholder = "Search \(user.login)'s followers"
        searchField.searchBar.delegate = self
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createFlowLayout())
        collectionView.backgroundColor = backgroundColor
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(collectionView)
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
        navigationItem.titleView = titleView
        navigationItem.searchController = searchField
    }
    
    private func getFollowers(for username: String, page: Int) {
        showLoadingView()
        
        NetworkService.shared.getFollowers(for: username, page: page) { [weak self] (followers, errorMessage) in
            guard let self = self else { return }
            
            self.dismissLoadingView()
            guard let followers = followers else {
                print(errorMessage!)
                return
            }
            
            if followers.count < 100 {
                self.hasMoreFollowers = false
            }
            self.followers.append(contentsOf: followers)
            
            if followers.isEmpty {
                let message = "No followers yet 😤"
                
                DispatchQueue.main.async {
                    self.showEmptyStateView(with: message, in: self.view)
                }
            }
            
            self.updateData(on: self.followers)
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(
            collectionView: collectionView,
            cellProvider: { (collectionView, IndexPath, follower) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FollowerCell.reuseID,
                    for: IndexPath) as! FollowerCell
                cell.set(follower: follower)
                
                return cell
            })
    }
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension FollowersViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(for: user.login, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower = followers[indexPath.item]
        presenter?.userTapped(withName: follower.login, by: user)
    }
}

extension FollowersViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchField.searchBar.text, !filter.isEmpty else { return }
        
        filteredFollowers = followers.filter {$0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: followers)
    }
}
