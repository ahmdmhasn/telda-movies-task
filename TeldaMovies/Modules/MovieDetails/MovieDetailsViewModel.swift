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
    let converter = MovieViewModelConverter()
    let movie: MovieEntity
    private var sections: [Section] = []
    private var onSync: () -> Void = { }

    private(set) var movieOverview: MovieOverviewTableViewCell.ViewModel
    private(set) var similarMoviesList: MoviesTableViewCell.ViewModel = []
    private(set) var actorsList: CastsTableViewCell.ViewModel = []
    private(set) var directorsList: CastsTableViewCell.ViewModel = []
    
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
            
            let movies = Array(value.results.prefix(5))
            self.loadSimilarMoviesCast(movies)
            self.similarMoviesList = self.converter.movieCellViewModels(of: movies)
            self.reloadSectionsAndSync()
        }
    }
}

// MARK: Similar Movies Cast Handlers
//
private extension MovieDetailsViewModel {
    
    func loadSimilarMoviesCast(_ movies: [MovieEntity]) {
        DispatchQueue.global().async {
            self.loadActorsAndDirectors(in: movies) { actors, directors in
                self.actorsList = actors.map(CastCollectionViewCell.ViewModel.init)
                self.directorsList = directors.map(CastCollectionViewCell.ViewModel.init)
                DispatchQueue.main.async {
                    self.reloadSectionsAndSync()
                }
            }
        }
    }
    
    func loadActorsAndDirectors(in movies: [MovieEntity], completion: @escaping ([CastEntity], [CastEntity]) -> Void) {
        var actors: Set<CastEntity> = []
        var directors: Set<CastEntity> = []
        let dispatchGroup = DispatchGroup()
        
        movies.forEach { movie in
            dispatchGroup.enter()
            loadMovieCast(movie) { credits in
                defer { dispatchGroup.leave() }
                
                let cast = credits?.cast ?? []
                for item in cast where item.knownForDepartment == .acting {
                    actors.insert(item)
                }
                
                for item in cast where item.knownForDepartment == .directing {
                    directors.insert(item)
                }
            }
        }
        
        dispatchGroup.notify(queue: .global()) {
            let sortedActors = actors
                .sorted(by: { $0.popularity ?? .zero > $1.popularity ?? .zero })
                .prefix(5)
            let sortedDirectors = directors
                .sorted(by: { $0.popularity ?? .zero > $1.popularity ?? .zero })
                .prefix(5)
            completion(Array(sortedActors), Array(sortedDirectors))
        }
    }
    
    func loadMovieCast(_ movie: MovieEntity, completion: @escaping (MovieCreditsEntity?) -> Void) {
        networking.movieCredits(id: String(movie.id)) { result in
            let credits = try? result.get()
            completion(credits)
        }
    }
}

// MARK: Reload Sections
//
private extension MovieDetailsViewModel {

    func reloadSections() {
        self.sections = {
            var sections: [Section] = []
            
            sections.append(Section(rows: [.overview, .tagline, .revenue, .releaseDate, .status]))
            
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
        case tagline
        case revenue
        case releaseDate
        case status
        case similarMovies
        case actors
        case directors
        
        var reuseIdentifier: String {
            switch self {
            case .overview:
                return MovieOverviewTableViewCell.reuseIdentifier
            case .tagline, .revenue, .releaseDate, .status:
                return KeyValueTableViewCell.reuseIdentifier
            case .similarMovies:
                return MoviesTableViewCell.reuseIdentifier
            case .actors, .directors:
                return CastsTableViewCell.reuseIdentifier
            }
        }
    }
}
