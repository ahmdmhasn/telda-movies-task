//
//  MovieCreditsEntity.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 24/11/2022.
//

import Foundation

// MARK: - MovieCreditsEntity
//
struct MovieCreditsEntity: Decodable {
    let id: Int
    let cast, crew: [CastEntity]?
}
