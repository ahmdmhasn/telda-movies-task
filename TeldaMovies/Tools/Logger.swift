//
//  Logger.swift
//  TeldaMovies
//
//  Created by Ahmed M. Hassan on 23/11/2022.
//

import Foundation

struct Logger {
    static func info(_ message: Any) {
        print("âšī¸", message)
    }
    
    static func error(_ message: Any) {
        print("â", message)
    }
    
    static func fatal(_ message: Any) -> Never {
        print("â", message)
        fatalError("\(message)")
    }
}
