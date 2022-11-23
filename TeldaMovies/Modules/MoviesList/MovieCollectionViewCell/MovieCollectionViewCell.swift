//
//  MovieCollectionViewCell.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 24/11/2022.
//

import UIKit

// MARK: MovieCollectionViewCell
//
class MovieCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: MovieCollectionViewCell.self)

    // MARK: Outlets
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var favoriteImageView: UIImageView!
        
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureTitleLabel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureGradient()
    }

    // MARK: Configurations
    
    func configure(_ viewModel: ViewModel) {
        titleLabel.text = viewModel.title
        favoriteImageView.isHidden = !viewModel.isFavorite
    }
}

// MARK: Configurations
//
private extension MovieCollectionViewCell {
    
    func configureGradient() {
        if let gradient = posterImageView.layer.sublayers?.last as? CAGradientLayer {
            gradient.removeFromSuperlayer()
        }
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.5, 1.0]

        posterImageView.layer.addSublayer(gradient)
    }
    
    func configureTitleLabel() {
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 3
        titleLabel.font = .preferredFont(forTextStyle: .headline)
    }
}

// MARK: ViewModel
//
extension MovieCollectionViewCell {
    struct ViewModel {
        let title: String
        let posterUrl: String
        let isFavorite: Bool
    }
}
