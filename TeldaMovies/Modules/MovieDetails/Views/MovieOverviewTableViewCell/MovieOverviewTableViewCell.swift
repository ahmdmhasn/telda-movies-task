//
//  MovieOverviewTableViewCell.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 25/11/2022.
//

import UIKit

class MovieOverviewTableViewCell: UITableViewCell {

    // MARK: Outlets
    
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var movieDescription: UILabel!
    
    // MARK: Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieDescription.textColor = .darkGray
        movieDescription.font = .preferredFont(forTextStyle: .callout)
    }
    
    // MARK: Configuration

    func configure(_ viewModel: ViewModel) {
        movieImageView.setImage(viewModel.imagePath)
        movieDescription.text = viewModel.overview
    }
}

// MARK: ViewModel
//
extension MovieOverviewTableViewCell {
    struct ViewModel {
        let title: String
        let imagePath: String
        let overview: String
        let tagline: String
        let revenue: String
        let releaseDate: String
        let statues: String
        
        init(movie: MovieEntity) {
            self.title = movie.title ?? String()
            self.imagePath = TMDBImageBuilder(path: movie.posterPath ?? String(), type: .original)
                .absolutePath()
            self.overview = movie.overview ?? String()
            self.tagline = movie.tagline ?? String()
            self.revenue = movie.revenue.map { String($0) } ?? String()
            self.releaseDate = movie.releaseDate ?? String()
            self.statues = movie.status ?? String()
        }
    }
}
