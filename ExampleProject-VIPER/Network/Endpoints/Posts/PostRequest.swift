//
//  PostRequest.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 14.07.2026.
//

import Foundation

class PostRequest: BaseRequest {
    override var path: String { NetworkConstants.EndpointPath.postPath }
}
