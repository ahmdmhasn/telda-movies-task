//
//  MovieViewModelConverter.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 25/11/2022.
//

import Foundation

struct MovieViewModelConverter {
    private let watchlistStore = MoviesWatchlistStore()
    
    func movieCellViewModels(of movies: [MovieEntity]) -> [MovieCollectionViewCell.ViewModel] {
        let watchlist = Set(watchlistStore.moviesWatchlist())
        return movies.map { movie in
            let isFavorite = watchlist.contains(movie.id)
            return MovieCollectionViewCell.ViewModel(movie: movie, isFavorite: isFavorite)
        }
    }
}
