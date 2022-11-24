//  
//  MoviesListViewModelType.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 24/11/2022.
//

import Foundation

/// MoviesList Input & Output
///
typealias MoviesListViewModelType = MoviesListViewModelInput & MoviesListViewModelOutput

/// MoviesList ViewModel Input
///
protocol MoviesListViewModelInput {
    func viewDidLoad()
    func didUpdateSearchText(_ keyword: String)
    func didSelectMovie(at indexPath: IndexPath)
}

/// MoviesList ViewModel Output
///
protocol MoviesListViewModelOutput {
    func onSync(onSync: @escaping () -> Void)
    func onShowMovieDetails(onShow: @escaping (MovieEntity) -> Void)
    func movieViewModel(at indexPath: IndexPath) -> MovieCollectionViewCell.ViewModel
    func numberOfSections() -> Int
    func numberOfMovies(in section: Int) -> Int
    func title(of section: Int) -> String
}
