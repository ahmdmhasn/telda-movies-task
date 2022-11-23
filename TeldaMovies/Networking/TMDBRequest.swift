//
//  TMDBRequest.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 23/11/2022.
//

import Foundation

// MARK: - TMDBRequest
//
struct TMDBRequest {
    let path: String
    let method: String
    
    func asURLRequest() -> URLRequest {
        var components = URLComponents(string: Constants.baseUrl + path)!
        components.queryItems = [URLQueryItem(name: "api_key", value: Constants.apiKey)]
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}

// MARK: - Constants
//
extension TMDBRequest {
    
    /// Used to store credentials.
    ///
    /// Note: - Should be replaced with CocoapodsKeys or similar dependency in production.
    ///
    enum Constants {
        
        /// TMDB API Key
        ///
        static let apiKey = "6e902ca7ab53142340b3b09e3746bfcc"
        
        /// TMDB Base url
        ///
        static let baseUrl = "https://api.themoviedb.org/3/"
    }
}
