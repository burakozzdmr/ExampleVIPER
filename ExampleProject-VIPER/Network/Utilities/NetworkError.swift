//
//  NetworkError.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 14.07.2026.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestTimeOut
    case invalidResponse
    case serverError
    case noInternet
    case decodingError
    case noData
    
    var errorMessage: String {
        switch self {
        case .invalidURL:
            "Invalid URL"
        case .requestTimeOut:
            "Request timeout"
        case .invalidResponse:
            "Invalid response"
        case .serverError:
            "Server error"
        case .noInternet:
            "No internet connection"
        case .decodingError:
            "Decoding error"
        case .noData:
            "No data"
        }
    }
}
