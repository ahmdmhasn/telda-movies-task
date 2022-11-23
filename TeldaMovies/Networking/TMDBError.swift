//
//  TMDBError.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 23/11/2022.
//

import Foundation

// MARK: - TMDBError
//
struct TMDBError: Decodable, LocalizedError {
    let statusCode: Int
    let statusMessage: String
    let success: Bool

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
    
    var errorDescription: String? {
        return statusMessage
    }
}
