//
//  TMDBImageBuilder.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 24/11/2022.
//

import Foundation

/// Build different image paths based on the image path and size.
///
struct TMDBImageBuilder {
    enum Size {
        case original
        case w500
    }
    
    let path: String
    let type: Size
    
    func absolutePath() -> String {
        return "https://image.tmdb.org/t/p/\(type)\(path)"
    }
}
