//
//  Object+ReuseIdentifier.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 25/11/2022.
//

import Foundation

extension NSObject {
    
    /// A string for identifying a reusable object.
    ///
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
