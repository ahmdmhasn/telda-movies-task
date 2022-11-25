//  
//  MovieDetailsViewModelType.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 24/11/2022.
//

import Foundation

/// MovieDetails Input & Output
///
typealias MovieDetailsViewModelType = MovieDetailsViewModelInput & MovieDetailsViewModelOutput

/// MovieDetails ViewModel Input
///
protocol MovieDetailsViewModelInput {
  func viewDidLoad()
}

/// MovieDetails ViewModel Output
///
protocol MovieDetailsViewModelOutput {
    var title: String { get }
    var movieOverview: MovieOverviewTableViewCell.ViewModel { get }
    var similarMoviesList: [MovieCollectionViewCell.ViewModel] { get }
    var actorsList: CastsTableViewCell.ViewModel { get }
    var directorsList: CastsTableViewCell.ViewModel { get }

    func onSync(onSync: @escaping () -> Void)
    func numberOfSections() -> Int
    func numberOfRows(at section: Int) -> Int
    func sectionTitle(at section: Int) -> String?
    func row(at indexPath: IndexPath) -> MovieDetailsViewModel.RowType
}
