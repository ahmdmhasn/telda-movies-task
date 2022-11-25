//
//  CastCollectionViewCell.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 25/11/2022.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {

    // MARK: Outlets
    
    @IBOutlet private weak var castImageView: UIImageView!
    @IBOutlet private weak var castNameLabel: UILabel!
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        castImageView.layer.masksToBounds = true
        castNameLabel.numberOfLines = 1
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        castImageView.layer.cornerRadius = bounds.width / 2
    }

    // MARK: Configuration
    
    func configure(_ viewModel: ViewModel) {
        castImageView.setImage(viewModel.imageUrl)
        castNameLabel.text = viewModel.name
    }
}

// MARK: ViewModel
//
extension CastCollectionViewCell {
    struct ViewModel {
        let imageUrl: String
        let name: String
        
        init(imageUrl: String, name: String) {
            self.imageUrl = imageUrl
            self.name = name
        }
        
        init(entity: CastEntity) {
            self.name = entity.name ?? String()
            self.imageUrl = TMDBImageBuilder(path: entity.profilePath ?? "", type: .w500).absolutePath()
        }
    }
}
