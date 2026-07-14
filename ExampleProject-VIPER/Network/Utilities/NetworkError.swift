//
//  NetworkError.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 14.07.2026.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case noData
    case generalError(Error)

    var errorMessage: String {
        switch self {
        case .invalidURL:
            return "Geçersiz URL. Lütfen tekrar deneyin."
        case .invalidResponse:
            return "Sunucudan geçersiz bir yanıt alındı."
        case .decodingError:
            return "Veri işlenirken bir hata oluştu."
        case .noData:
            return "Sunucudan herhangi bir veri alınamadı."
        case .generalError(let error):
            return "Bir hata oluştu: \(error.localizedDescription)"
        }
    }
}
