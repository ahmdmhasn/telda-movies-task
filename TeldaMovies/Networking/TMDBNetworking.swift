//
//  Networking.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 23/11/2022.
//

import Foundation

// MARK: - TMDBNetworking
//
final class TMDBNetworking {
    private let session = URLSession.shared
    
    private func perform<T: Decodable>(_ request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        session.dataTask(with: request) { data, response, error in
            do {
                guard let data = data else {
                    throw error ?? Errors.unexpectedError
                }
                
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }.resume()
    }
}

// MARK: - Requests
//
extension TMDBNetworking {
    
}

// MARK: - Errors
//
private extension TMDBNetworking {
    enum Errors: LocalizedError {
        case unexpectedError
    }
}
