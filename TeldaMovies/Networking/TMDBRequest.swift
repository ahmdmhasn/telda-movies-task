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
    let parameters: [String: String]
        
    init(path: String, method: String, parameters: [String: String] = [:]) {
        self.path = path
        self.method = method
        self.parameters = parameters
    }
}

// MARK: URLRequest Generator
//
extension TMDBRequest {
    func asURLRequest() -> URLRequest {
        var components = URLComponents(string: Constants.baseUrl + path)!
        components.queryItems = parameters
            .merging(["api_key": Constants.apiKey], uniquingKeysWith: { (current, _) in current })
            .map { URLQueryItem(name: $0.key, value: $0.value) }
        
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
