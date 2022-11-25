//
//  MovieCollectionViewHeader.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 24/11/2022.
//

import UIKit

final class MovieCollectionViewHeader: UICollectionReusableView {
    
    @IBOutlet private var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = .preferredFont(forTextStyle: .title3)
        titleLabel.textColor = .darkGray
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
