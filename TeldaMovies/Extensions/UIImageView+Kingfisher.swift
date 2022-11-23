//
//  UIImageView+Kingfisher.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 24/11/2022.
//

import UIKit
import Kingfisher

/// Acts as a wrapper for Kingfisher
///
extension UIImageView {
    
    /// Set image with url as string.
    ///
    func setImage(_ urlString: String) {
        kf.indicatorType = .activity
        kf.setImage(with: URL(string: urlString),
                    placeholder: UIImage(named: "movie-pattern"),
                    options: [.transition(ImageTransition.fade(0.3))])
    }
}
