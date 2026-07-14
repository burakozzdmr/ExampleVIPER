//
//  CommentService.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 14.07.2026.
//

import Foundation

// MARK: - CommentServiceProtocol

protocol CommentServiceProtocol: AnyObject {
    func fetchComments(
        request: CommentRequest,
        completion: @escaping (Result<CommentResponse, NetworkError>) -> Void
    )
}

// MARK: - CommentService

class CommentService {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

// MARK: - CommentServiceProtocol Methods

extension CommentService: CommentServiceProtocol {
    func fetchComments(
        request: CommentRequest,
        completion: @escaping (Result<CommentResponse, NetworkError>) -> Void
    ) {
        networkManager.sendRequest(
            request: request,
            type: CommentResponse.self,
            completion: completion
        )
    }
}
