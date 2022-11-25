//
//  MovieOverviewTableViewCell.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 25/11/2022.
//

import UIKit

class MovieOverviewTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ viewModel: ViewModel) {
        // TODO:
    }
}

extension MovieOverviewTableViewCell {
    struct ViewModel {
        let title: String
        
        init(movie: MovieEntity) {
            self.title = movie.title ?? ""
        }
    }
}
