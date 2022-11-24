//  
//  MovieDetailsViewModel.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 24/11/2022.
//

import Foundation

// MARK: MovieDetailsViewModel
//
final class MovieDetailsViewModel {
    let movie: MovieEntity
    
    init(movie: MovieEntity) {
        self.movie = movie
    }
}

// MARK: MovieDetailsViewModel

extension MovieDetailsViewModel: MovieDetailsViewModelInput {

}

// MARK: MovieDetailsViewModelOutput
//
extension MovieDetailsViewModel: MovieDetailsViewModelOutput {

}

// MARK: Private Handlers
//
private extension MovieDetailsViewModel {

}
