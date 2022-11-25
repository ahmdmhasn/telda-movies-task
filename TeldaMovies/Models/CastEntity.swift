//
//  CastEntity.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 24/11/2022.
//

import Foundation

// MARK: - CastEntity
//
struct CastEntity: Decodable {
    let id: Int
    let adult: Bool?
    let gender: Int?
    let knownForDepartment: Department?
    let name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character, creditID: String?
    let order: Int?
    let department: String?
    let job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
    
    enum Department: String, Decodable {
        case acting = "Acting"
        case art = "Art"
        case camera = "Camera"
        case costumeMakeUp = "Costume & Make-Up"
        case crew = "Crew"
        case directing = "Directing"
        case editing = "Editing"
        case lighting = "Lighting"
        case production = "Production"
        case sound = "Sound"
        case visualEffects = "Visual Effects"
        case writing = "Writing"
        case unknown
        
        init(from decoder: Decoder) throws {
            let rawValue = try decoder.singleValueContainer().decode(RawValue.self)
            self = Department(rawValue: rawValue) ?? .unknown
        }
    }
}

// MARK: Hashable
//
extension CastEntity: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
