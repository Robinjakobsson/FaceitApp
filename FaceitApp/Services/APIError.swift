//
//  APIError.swift
//  FaceitApp
//
//  Created by Robin jakobsson on 2025-06-04.
//

import Foundation

enum APIError : Error, LocalizedError {
    case InvalidURL
    case badResponse(Int)
    case decodingError
    case Unknown(Error)
    case InvalidAPIKey
    
    var errorDescription: String? {
        switch self {
        case .InvalidURL:
            return "Invalid URL"
        case .badResponse(let code):
            return "Server side problems \(code)"
        case .decodingError:
            return "Error decoding Player"
        case .Unknown(let error):
            return "Unknown error \(error.localizedDescription)"
        case .InvalidAPIKey:
            return "Bad api Key"
        }
    }
}
