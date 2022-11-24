//  
//  MoviesListViewModel.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 24/11/2022.
//

import Foundation

// MARK: MoviesListViewModel
//
class MoviesListViewModel {
    let networking = TMDBNetworking()
    private var onSync: () -> Void = { }
    private var cachedPopularMoviesSections: [Section]?
    private var sections: [Section] = [] {
        didSet { onSync() }
    }
}

// MARK: MoviesListViewModel

extension MoviesListViewModel: MoviesListViewModelInput {
    
    func viewDidLoad() {
        loadPopularMovies()
    }
    
    func didUpdateSearchText(_ keyword: String) {
        if keyword.isEmpty {
            loadPopularMovies()
        } else {
            loadSearchMovies(with: keyword)
        }
    }
        
    func didSelectMovie(at indexPath: IndexPath) {
        // TODO:
    }
}

// MARK: MoviesListViewModelOutput
//
extension MoviesListViewModel: MoviesListViewModelOutput {
    
    func onSync(onSync: @escaping () -> Void) {
        self.onSync = onSync
    }
    
    func movieViewModel(at indexPath: IndexPath) -> MovieCollectionViewCell.ViewModel {
        return sections[indexPath.section].movies[indexPath.row]
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfMovies(in section: Int) -> Int {
        return sections[section].movies.count
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
                let movies = value.map { MovieCollectionViewCell.ViewModel(movie: $0, isFavorite: true) }
                return Section(title: key ?? "N/A", movies: movies)
            }
            .sorted { $0.title < $1.title }
    }
}

// MARK: Nested Types
//
extension MoviesListViewModel {
    
    struct Section {
        let title: String
        let movies: [MovieCollectionViewCell.ViewModel]
    }
}
