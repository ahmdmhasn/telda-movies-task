//  
//  MoviesListViewModel.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 24/11/2022.
//

import Foundation

// MARK: MoviesListViewModel
//
final class MoviesListViewModel {
    let networking = TMDBNetworking()
    let converter = MovieViewModelConverter()
    let center = NotificationCenter.default
    
    private var onSync: () -> Void = { }
    private var onShowMovieDetails: (MovieEntity) -> Void = { _ in }
    private var cachedPopularMoviesSections: [Section]?
    private var sections: [Section] = [] {
        didSet { onSync() }
    }
}

// MARK: MoviesListViewModel

extension MoviesListViewModel: MoviesListViewModelInput {
    
    func viewDidLoad() {
        loadPopularMovies()
        observeWishlistUpdates()
    }
    
    func didUpdateSearchText(_ keyword: String) {
        if keyword.isEmpty {
            loadPopularMovies()
        } else {
            loadSearchMovies(with: keyword)
        }
    }
        
    func didSelectMovie(at indexPath: IndexPath) {
        let row = sections[indexPath.section].movies[indexPath.row]
        onShowMovieDetails(row.movie)
    }
}

// MARK: MoviesListViewModelOutput
//
extension MoviesListViewModel: MoviesListViewModelOutput {    
    
    func onSync(onSync: @escaping () -> Void) {
        self.onSync = onSync
    }
    
    func onShowMovieDetails(onShow: @escaping (MovieEntity) -> Void) {
        self.onShowMovieDetails = onShow
    }
    
    func movieViewModel(at indexPath: IndexPath) -> MovieCollectionViewCell.ViewModel {
        return sections[indexPath.section].movies[indexPath.row].cellViewModel
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfMovies(in section: Int) -> Int {
        return sections[section].movies.count
    }
    
    func title(of section: Int) -> String {
        return sections[section].title
    }
}

// MARK: Wishlist Sync
//
private extension MoviesListViewModel {
    
    func observeWishlistUpdates() {
        center.addObserver(self, selector: #selector(movieWishlistWasUpdatedNotification), name: .MovieWishlistWasUpdated, object: nil)
    }
    
    @objc func movieWishlistWasUpdatedNotification(_ notification: Notification) {
        // For the sake of simplicity, I will reset and load the whole data.
        // Best practice, we need to update the changed movie only based on the movie id.
        cachedPopularMoviesSections = nil
        loadPopularMovies()
    }
}

// MARK: Networking Handlers
//
private extension MoviesListViewModel {
    
    func loadPopularMovies() {
        if let cached = cachedPopularMoviesSections {
            sections = cached
            return
        }
        
        networking.popularMovies { [weak self] result in
            self?.parsePaginatedResultAndSyncState(result, onParseSections: { sections in
                self?.cachedPopularMoviesSections = sections
            })
        }
    }
    
    func loadSearchMovies(with keyword: String) {
        networking.searchMovies(keyword: keyword) { [weak self] result in
            self?.parsePaginatedResultAndSyncState(result, onParseSections: { _ in })
        }
    }
    
    func parsePaginatedResultAndSyncState(_ result: NetworkResult<PaginatedMoviesList>,
                                          onParseSections: @escaping ([Section]) -> Void) {
        DispatchQueue.global().async {
            switch result {
            case .success(let value):
                let sections = self.parseMoviesListIntoSections(value.results)
                self.sections = sections
                onParseSections(sections)
            case .failure:
                // We don't currently handle the error for the sake of time and complexity.
                self.sections = []
            }
        }
    }
    
    func parseMoviesListIntoSections(_ movies: [MovieEntity]) -> [Section] {
        return Dictionary(grouping: movies, by: { $0.releaseYear })
            .map { key, value in
                let movies = converter.movieCellViewModels(of: value)
                let rows = zip(value, movies).map { Row(movie: $0, cellViewModel: $1) }
                return Section(title: key ?? "N/A", movies: rows)
            }
            .sorted { $0.title > $1.title }
    }
}

// MARK: Nested Types
//
extension MoviesListViewModel {
    typealias MovieCellViewModel = MovieCollectionViewCell.ViewModel
    
    struct Section {
        let title: String
        let movies: [Row]
    }
    
    struct Row {
        let movie: MovieEntity
        let cellViewModel: MovieCellViewModel
    }
}
