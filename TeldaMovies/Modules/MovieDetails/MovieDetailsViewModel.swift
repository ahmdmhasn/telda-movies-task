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
    let networking = TMDBNetworking()
    let movie: MovieEntity
    private var sections: [Section] = []
    private var onSync: () -> Void = { }

    private(set) var movieOverview: MovieOverviewTableViewCell.ViewModel
    private(set) var similarMoviesList: MoviesTableViewCell.ViewModel = []
    private(set) var actorsList: CastsTableViewCell.ViewModel = [.init(imageUrl: "", name: "Movie 1")]
    private(set) var directorsList: CastsTableViewCell.ViewModel = [.init(imageUrl: "", name: "Movie 1")]
    
    init(movie: MovieEntity) {
        self.movie = movie
        self.movieOverview = MovieOverviewTableViewCell.ViewModel(movie: movie)
        self.similarMoviesList = [MovieCollectionViewCell.ViewModel(movie: movie, isFavorite: false)]
    }
}

// MARK: MovieDetailsViewModel Input
//
extension MovieDetailsViewModel: MovieDetailsViewModelInput {
    func viewDidLoad() {
        reloadSectionsAndSync()
        loadMovieOverview()
        loadSimilarMovies()
    }
}

// MARK: MovieDetailsViewModelOutput
//
extension MovieDetailsViewModel: MovieDetailsViewModelOutput {
    
    var title: String {
        return movieOverview.title
    }
    
    func onSync(onSync: @escaping () -> Void) {
        self.onSync = onSync
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfRows(at section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func sectionTitle(at section: Int) -> String? {
        return sections[section].title
    }
    
    func row(at indexPath: IndexPath) -> MovieDetailsViewModel.RowType {
        return sections[indexPath.section].rows[indexPath.row]
    }
}

// MARK: Private Handlers
//
private extension MovieDetailsViewModel {
    
    func reloadSectionsAndSync() {
        reloadSections()
        onSync()
    }
    
    func loadMovieOverview() {
        networking.movieDetails(id: String(movie.id)) { [weak self] result in
            guard let self = self, case .success(let movie) = result else {
                return
            }
            
            let movieOverview = MovieOverviewTableViewCell.ViewModel(movie: movie)
            self.movieOverview = movieOverview
            self.reloadSectionsAndSync()
        }
    }
    
    func loadSimilarMovies() {
        networking.similarMovies(id: String(movie.id)) { [weak self] result in
            guard let self = self, case .success(let value) = result else {
                return
            }
            
            self.similarMoviesList = value.results.map { MoviesTableViewCell.Element(movie: $0, isFavorite: false) }
            self.reloadSectionsAndSync()
        }
    }
}

// MARK: Reload Sections
//
private extension MovieDetailsViewModel {

    func reloadSections() {
        self.sections = {
            var sections: [Section] = []
            
            sections.append(Section(rows: [.overview]))
            
            if similarMoviesList.isNotEmpty {
                sections.append(Section(title: "Similar Movies", rows: [.similarMovies]))
            }
            
            if actorsList.isNotEmpty {
                sections.append(Section(title: "Actors", rows: [.actors]))
            }
            
            if directorsList.isNotEmpty {
                sections.append(Section(title: "Directors", rows: [.directors]))
            }
            
            return sections
        }()
    }
}

// MARK: Nested Types
//
extension MovieDetailsViewModel {
    
    struct Section {
        let title: String?
        let rows: [RowType]
        
        init(title: String? = nil, rows: [MovieDetailsViewModel.RowType]) {
            self.title = title
            self.rows = rows
        }
    }
    
    enum RowType {
        case overview
        case similarMovies
        case actors
        case directors
        
        var reuseIdentifier: String {
            switch self {
            case .overview:
                return MovieOverviewTableViewCell.reuseIdentifier
            case .similarMovies:
                return MoviesTableViewCell.reuseIdentifier
            case .actors, .directors:
                return CastsTableViewCell.reuseIdentifier
            }
        }
    }
}
