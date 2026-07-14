//
//  PostService.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 14.07.2026.
//

import Foundation

// MARK: - PostServiceProtocol

protocol PostServiceProtocol: AnyObject {
    func fetchPosts(
        request: PostRequest,
        completion: @escaping (Result<PostResponse, NetworkError>) -> Void
    )
}

// MARK: - PostService

class PostService {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

// MARK: - PostServiceProtocol Methods

extension PostService: PostServiceProtocol {
    func fetchPosts(
        request: PostRequest,
        completion: @escaping (Result<PostResponse, NetworkError>) -> Void
    ) {
        networkManager.sendRequest(
            request: request,
            type: PostResponse.self,
            completion: completion
        )
    }
}
