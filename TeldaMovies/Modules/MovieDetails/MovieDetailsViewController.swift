//  
//  MovieDetailsViewController.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 24/11/2022.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: Properties
        
    private let viewModel: MovieDetailsViewModelType

    // MARK: Init
        
    init(viewModel: MovieDetailsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.register(MovieOverviewTableViewCell.self)
        tableView.register(KeyValueTableViewCell.self)
        tableView.register(MoviesTableViewCell.self)
        tableView.register(CastsTableViewCell.self)
        
        viewModel.onSync { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.viewDidLoad()
        
        navigationItem.title = viewModel.title
    }
}

// MARK: - Actions
//
extension MovieDetailsViewController {
    
}

// MARK: - Configurations
//
extension MovieDetailsViewController {
    
}

// MARK: - UITableViewDataSource
//
extension MovieDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = viewModel.row(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier, for: indexPath)
        configure(cell, at: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate
//
extension MovieDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitle(at: section)
    }
}

// MARK: - Configure Cell
//
private extension MovieDetailsViewController {
    
    func configure(_ cell: UITableViewCell, at indexPath: IndexPath) {
        let row = viewModel.row(at: indexPath)
        switch cell {
        case let cell as MovieOverviewTableViewCell:
            configureMovieOverview(cell)
        case let cell as KeyValueTableViewCell where row == .tagline:
            configureTaglineCell(cell)
        case let cell as KeyValueTableViewCell where row == .revenue:
            configureRevenueCell(cell)
        case let cell as KeyValueTableViewCell where row == .releaseDate:
            configureReleaseDateCell(cell)
        case let cell as KeyValueTableViewCell where row == .status:
            configureStatusCell(cell)
        case let cell as MoviesTableViewCell:
            configureSimilarMovies(cell)
        case let cell as CastsTableViewCell where row == .actors:
            configureActors(cell)
        case let cell as CastsTableViewCell where row == .directors:
            configureDirectors(cell)
        default:
            Logger.fatal("Unexpected row type.")
        }
    }
    
    func configureMovieOverview(_ cell: MovieOverviewTableViewCell) {
        cell.configure(viewModel.movieOverview)
    }
    
    func configureTaglineCell(_ cell: KeyValueTableViewCell) {
        let viewModel = KeyValueTableViewCell.ViewModel(key: "Tagline",
                                                        value: viewModel.movieOverview.tagline)
        cell.configure(viewModel)
    }
    
    func configureRevenueCell(_ cell: KeyValueTableViewCell) {
        let viewModel = KeyValueTableViewCell.ViewModel(key: "Revenue",
                                                        value: viewModel.movieOverview.revenue)
        cell.configure(viewModel)
    }
    
    func configureReleaseDateCell(_ cell: KeyValueTableViewCell) {
        let viewModel = KeyValueTableViewCell.ViewModel(key: "Release Date",
                                                        value: viewModel.movieOverview.releaseDate)
        cell.configure(viewModel)
    }
    
    func configureStatusCell(_ cell: KeyValueTableViewCell) {
        let viewModel = KeyValueTableViewCell.ViewModel(key: "Status",
                                                        value: viewModel.movieOverview.statues)
        cell.configure(viewModel)
    }
    
    func configureSimilarMovies(_ cell: MoviesTableViewCell) {
        cell.configure(viewModel.similarMoviesList)
    }
    
    func configureActors(_ cell: CastsTableViewCell) {
        cell.configure(viewModel.actorsList)
    }
    
    func configureDirectors(_ cell: CastsTableViewCell) {
        cell.configure(viewModel.directorsList)
    }
}
