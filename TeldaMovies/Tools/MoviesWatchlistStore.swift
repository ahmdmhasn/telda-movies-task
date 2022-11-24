//
//  MoviesWatchlistStore.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 24/11/2022.
//

import Foundation

final class MoviesWatchlistStore {
    private let defaults = UserDefaults.standard
    
    private var watchlist: [Int]? {
        get { defaults.value(forKey: "movies-watchlist") as? [Int] }
        set { defaults.set(newValue, forKey: "movies-watchlist")}
    }
    
    func addMovieToWatchlist(_ movie: MovieEntity) {
        var watchlist = self.watchlist ?? []
        watchlist.append(movie.id)
        self.watchlist = watchlist
    }
    
    func removeMovieFromWatchlist(_ movie: MovieEntity) {
        var watchlist = self.watchlist ?? []
        watchlist.removeAll { $0 == movie.id }
        self.watchlist = watchlist
    }
    
    func moviesWatchlist() -> [Int] {
        return watchlist ?? []
    }
}
