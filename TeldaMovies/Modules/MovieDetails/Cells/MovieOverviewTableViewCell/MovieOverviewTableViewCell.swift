//
//  MovieOverviewTableViewCell.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 25/11/2022.
//

import UIKit

class MovieOverviewTableViewCell: UITableViewCell {

    // MARK: Outlets
    
    
    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: Configuration

    func configure(_ viewModel: ViewModel) {
        // TODO:
    }
}

// MARK: ViewModel
//
extension MovieOverviewTableViewCell {
    struct ViewModel {
        let title: String
        let overview: String
        let tagline: String
        let revenue: String
        let releaseDate: String
        let statues: String
        
        init(movie: MovieEntity) {
            self.title = movie.title ?? String()
            self.overview = movie.overview ?? String()
            self.tagline = movie.tagline ?? String()
            self.revenue = movie.revenue.map { String($0) } ?? String()
            self.releaseDate = movie.releaseDate ?? String()
            self.statues = movie.status ?? String()
        }
    }
}
