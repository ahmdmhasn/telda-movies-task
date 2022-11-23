//
//  PaginatedList.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 23/11/2022.
//

import Foundation

typealias PaginatedMoviesList = PaginatedList<MovieEntity>

// MARK: - PaginatedList
//
struct PaginatedList<T: Decodable>: Decodable {
    let page: Int
    let results: [T]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
