//
//  FavouritesTableView.swift
//  GitChecker
//
//  Created by Данила Рахманов on 05.05.2024.
//

import UIKit

final class FavouritesTableView: UITableView {
    var presenter: WelcomePresenter?
    
    private var favouriteFollowers: [Follower] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        fetchData()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isEmpty() -> Bool {
        return favouriteFollowers.count == 0
    }
    
    private func configure() {
        backgroundColor = .systemGray6
        delegate = self
        dataSource = self
        register(FavouriteCell.self, forCellReuseIdentifier: "FavouriteCell")
        layer.cornerRadius = 15
        rowHeight = 50
        
        isScrollEnabled = true
        updateHeight()
    }
    
    private func updateHeight() {
        let height = rowHeight * CGFloat(favouriteFollowers.count)
        setHeight(height)
    }
}

extension FavouritesTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteFollowers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: "FavouriteCell") as! FavouriteCell
        let follower = favouriteFollowers[indexPath.row]
        cell.set(follower: follower)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favourite = favouriteFollowers[indexPath.row]
        presenter?.favouriteTapped(by: favourite)
    }
}

extension FavouritesTableView {
    func fetchData() {
        PersistenceService.retrieveFavourites { [weak self] (favourites, errorMessage) in
            guard let self = self else {
                return
            }
            
            guard let favourites = favourites else {
                return
            }
            
            self.favouriteFollowers = favourites
            DispatchQueue.main.async {
                self.reloadData()
            }
            //self.updateHeight()
        }
    }
}
