//
//  NetworkConstants.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 14.07.2026.
//

import Foundation

enum NetworkConstants {
    static let baseURL: String = "https://dummyjson.com"
    
    enum Headers {
        static let contentType: String = "Content-Type"
        static let applicationJson: String = "application/json"
    }
    
    enum EndpointPath {
        static let userPath: String = "/users"
        static let postPath: String = "/posts"
        static let commentPath: String = "/comments"
        static let productsPath: String = "/products"
    }
}
