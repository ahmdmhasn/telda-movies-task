//
//  Notification.Name+TeldaMovies.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 25/11/2022.
//

import Foundation

extension Notification.Name {
    
    /// Fired when a wishlist state for a movie is updated.
    ///
    /// - Note: Should have `id` added in the user info.
    static let MovieWishlistWasUpdated = Notification.Name("MovieWishlistWasUpdated")
}
