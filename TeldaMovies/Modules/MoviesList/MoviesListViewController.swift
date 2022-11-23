//  
//  MoviesListViewController.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 24/11/2022.
//

import UIKit

class MoviesListViewController: UIViewController {
    
    // MARK: Outlets

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
