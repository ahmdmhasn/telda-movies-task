//
//  Movie.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 23/11/2022.
//

import Foundation

// MARK: - MovieEntity
//
struct MovieEntity: Decodable {
    let id: Int
    let adult: Bool?
    let backdropPath: String?
    let budget: Int?
    let homepage: String?
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let revenue, runtime: Int?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

/// Helpers
///
extension MovieEntity {
    var releaseYear: String? {
        guard let value =  releaseDate?.split(separator: "-").first else {
            return nil
        }
        
        return String(value)
    }
}
