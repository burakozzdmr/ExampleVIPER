//
//  UserService.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 14.07.2026.
//

import Foundation

// MARK: - UserServiceProtocol

protocol UserServiceProtocol: AnyObject {
    func fetchUsers(
        request: UserRequest,
        completion: @escaping (Result<UserResponse, NetworkError>) -> Void
    )
}

// MARK: - UserService

class UserService {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

// MARK: - UserServiceProtocol Methods

extension UserService: UserServiceProtocol {
    func fetchUsers(
        request: UserRequest,
        completion: @escaping (Result<UserResponse, NetworkError>) -> Void
    ) {
        networkManager.sendRequest(
            request: request,
            type: UserResponse.self,
            completion: completion
        )
    }
}
