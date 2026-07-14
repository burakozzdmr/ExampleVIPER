//
//  CommentResponse.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 14.07.2026.
//

import Foundation
 
// MARK: - Root Response
 
struct CommentResponse: Decodable {
    let comments: [Comment]
    let total: Int
    let skip: Int
    let limit: Int
}
 
// MARK: - Comment
 
struct Comment: Decodable {
    let id: Int
    let body: String
    let postId: Int
    let likes: Int
    let user: CommentUser
}
 
// MARK: - CommentUser
 
struct CommentUser: Decodable {
    let id: Int
    let username: String
    let fullName: String
}
