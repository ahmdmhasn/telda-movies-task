//
//  Logger.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 23/11/2022.
//

import Foundation

struct Logger {
    static func info(_ message: Any) {
        print("ℹ️", message)
    }
    
    static func error(_ message: Any) {
        print("❌", message)
    }
}
