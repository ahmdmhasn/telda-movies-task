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
    
    private func perform<T: Decodable>(_ request: TMDBRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        session.dataTask(with: request.asURLRequest()) { data, response, error in
            do {
                guard let data = data else {
                    throw error ?? NetworkError.unexpectedError
                }
                
                Logger.info("API Response: \(String(data: data, encoding: .utf8) ?? "")")
                
                let decoder = JSONDecoder()
                
                if let error = try? decoder.decode(TMDBError.self, from: data) {
                    throw error
                }
                
                let decodedResponse = try decoder.decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                Logger.error(error)
                completion(.failure(error as? NetworkError ?? .unexpectedError))
            }
        }.resume()
    }
}

// MARK: - Requests
//
extension TMDBNetworking {
    
    func popularMovies(completion: @escaping (Result<PaginatedMoviesList, NetworkError>) -> Void) {
        let request = TMDBRequest(path: "movie/popular", method: "get")
        perform(request, completion: completion)
    }
}

// MARK: - NetworkError
//
extension TMDBNetworking {
    enum NetworkError: LocalizedError {
        case unexpectedError
        case underlying(LocalizedError)
        case serverError(TMDBError)
        
        var errorDescription: String? {
            switch self {
            case .unexpectedError:
                return "Something went wrong!"
            case .underlying(let error):
                return error.errorDescription
            case .serverError(let error):
                return error.errorDescription
            }
        }
    }
}
