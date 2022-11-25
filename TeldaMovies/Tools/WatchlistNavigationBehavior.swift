//
//  WatchlistNavigationBehavior.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 25/11/2022.
//

import UIKit

/// Used to handle watchlist navigation bar item with all the needed logic.
/// 
final class WatchlistNavigationBehavior {
    private let store = MoviesWatchlistStore()
    private let center = NotificationCenter.default
    
    let movie: MovieEntity
    let navigationItem: UINavigationItem
    
    func attachWishlistBarItem() {
        let barButtonItem = UIBarButtonItem(image: imageForCurrentState, style: .plain, target: self, action: #selector(toggleButton))
        barButtonItem.tintColor = .red
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    init(movie: MovieEntity, navigationItem: UINavigationItem) {
        self.movie = movie
        self.navigationItem = navigationItem
    }
}

// MARK: Private Handlers
//
private extension WatchlistNavigationBehavior {

    var imageForCurrentState: UIImage? {
        let isWatchlisted = store.isWatchlisted(movie)
        let name = isWatchlisted ? "favorite-filled-icon" : "favorite-outlined-icon"
        return UIImage(named: name)
    }
    
    @objc func toggleButton(_ sender: UIBarButtonItem) {
        toggleMovieWishlist()
        sender.image = imageForCurrentState
    }
    
    func toggleMovieWishlist() {
        if store.isWatchlisted(movie) {
            store.removeMovieFromWatchlist(movie)
        } else {
            store.addMovieToWatchlist(movie)
        }
        
        center.post(name: .MovieWishlistWasUpdated, object: ["id": movie.id])
    }
}
