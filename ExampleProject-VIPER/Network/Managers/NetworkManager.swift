//
//  NetworkManager.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 14.07.2026.
//

import Foundation

// MARK: - NetworkManagerProtocol

protocol NetworkManagerProtocol: AnyObject {
    func sendRequest<T: Decodable>(
        request: BaseRequest,
        type: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}

// MARK: - NetworkManager

class NetworkManager {
    private let session: URLSession
    
    init(session: URLSession = .init(configuration: .default)) {
        self.session = session
    }
}

// MARK: - NetworkManagerProtocol Methods

extension NetworkManager: NetworkManagerProtocol {
    func sendRequest<T: Decodable>(
        request: BaseRequest,
        type: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let requestStringURL = URL(string: request.fullEndpoint) else {
            return completion(.failure(.invalidURL))
        }
        
        let requestURL: URLRequest = .init(url: requestStringURL)
        
        session.dataTask(with: requestURL) { data, _, error in
            if error != nil {
                return completion(.failure(.invalidURL))
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        .resume()
    }
}
