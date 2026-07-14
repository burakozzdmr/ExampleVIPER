//
//  PostResponse.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 14.07.2026.
//

import Foundation
 
// MARK: - Root Response
 
struct PostResponse: Decodable {
    let posts: [Post]
    let total: Int
    let skip: Int
    let limit: Int
}
 
// MARK: - Post
 
struct Post: Decodable {
    let id: Int
    let title: String
    let body: String
    let tags: [String]
    let reactions: Reactions
    let views: Int
    let userId: Int
}
 
// MARK: - Reactions
 
struct Reactions: Decodable {
    let likes: Int
    let dislikes: Int
}
