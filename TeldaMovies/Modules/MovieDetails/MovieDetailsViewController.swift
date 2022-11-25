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

// MARK: - Private Handlers
//
private extension MovieDetailsViewController {
}

// MARK: - UITableViewDataSource
//
extension MovieDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
//
extension MovieDetailsViewController: UITableViewDelegate {
    
}
