//
//  ProductService.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 14.07.2026.
//

import Foundation

// MARK: - ProductServiceProtocol

protocol ProductServiceProtocol: AnyObject {
    func fetchProducts(
        request: ProductRequest,
        completion: @escaping (Result<ProductResponse, NetworkError>) -> Void
    )
}

// MARK: - ProductService

class ProductService {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

// MARK: - ProductService Methods

extension ProductService: ProductServiceProtocol {
    func fetchProducts(
        request: ProductRequest,
        completion: @escaping (Result<ProductResponse, NetworkError>) -> Void
    ) {
        networkManager.sendRequest(
            request: request,
            type: ProductResponse.self,
            completion: completion
        )
    }
}
