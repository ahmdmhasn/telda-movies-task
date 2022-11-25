//  
//  MoviesListViewController.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 24/11/2022.
//

import UIKit

final class MoviesListViewController: UIViewController {
    
    // MARK: Outlets

    @IBOutlet private weak var collectionView: UICollectionView!
    private let searchBar = UISearchBar(frame: .zero)

    // MARK: Properties
        
    private let viewModel: MoviesListViewModelType

    // MARK: Init
        
    init(viewModel: MoviesListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ConfigureNavigationItem()
        configureSearchBar()
        configureCollectionView()
        configureViewModel()
        
        viewModel.viewDidLoad()
    }
}

// MARK: - Configurations
//
extension MoviesListViewController {
    
    func ConfigureNavigationItem() {
        navigationItem.titleView = searchBar
    }
    
    func configureSearchBar() {
        searchBar.delegate = self
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: MovieCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
        collectionView.register(UINib(nibName: MovieCollectionViewHeader.reuseIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MovieCollectionViewHeader.reuseIdentifier)
    }
    
    func configureViewModel() {
        viewModel.onSync {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        viewModel.onShowMovieDetails { [weak self] movie in
            self?.showMovieDetails(movie)
        }
    }
}

// MARK: - Private Handlers
//
private extension MoviesListViewController {
    
    func showMovieDetails(_ movie: MovieEntity) {
        let viewModel = MovieDetailsViewModel(movie: movie)
        let viewController = MovieDetailsViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UISearchBarDelegate
//
extension MoviesListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.didUpdateSearchText(searchText)
    }
}

// MARK: - UICollectionViewDataSource
//
extension MoviesListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfMovies(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        let movieViewModel = viewModel.movieViewModel(at: indexPath)
        cell.configure(movieViewModel)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
//
extension MoviesListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectMovie(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MovieCollectionViewHeader.reuseIdentifier, for: indexPath) as! MovieCollectionViewHeader
        headerView.configure(title: viewModel.title(of: indexPath.section))
        return headerView
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
//
extension MoviesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.bounds.width - Metrics.spacing * 3
        let width = totalWidth / 2
        return CGSize(width: width, height: width * 1.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: .zero, left: Metrics.spacing, bottom: .zero, right: Metrics.spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Metrics.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Metrics.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: Metrics.headerHeight)
    }
}

// MARK: - Constants
//
extension MoviesListViewController {
    
    enum Metrics {
        static let spacing: CGFloat = 8.0
        static let headerHeight: CGFloat = 60.0
    }
}
