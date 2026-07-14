//
//  CommentRequest.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 14.07.2026.
//

import Foundation

class CommentRequest: BaseRequest {
    override var path: String { NetworkConstants.EndpointPath.commentPath }
}
