//  
//  MoviesListViewController.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 24/11/2022.
//

import UIKit

class MoviesListViewController: UIViewController {
    
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
        
        navigationItem.titleView = searchBar
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: MovieCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
    }
}

// MARK: - Actions
//
extension MoviesListViewController {
    
}

// MARK: - Configurations
//
extension MoviesListViewController {
    
}

// MARK: - Private Handlers
//
private extension MoviesListViewController {
}

// MARK: - UICollectionViewDataSource
//
extension MoviesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
//        cell.backgroundColor = .blue
        cell.configure(.init(title: "Movie", posterUrl: "", isFavorite: true))
        return cell
    }
}

// MARK: - UICollectionViewDelegate
//
extension MoviesListViewController: UICollectionViewDelegate {
    
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
}

// MARK: - Constants
//
extension MoviesListViewController {
    
    enum Metrics {
        static let spacing: CGFloat = 8.0
    }
}
