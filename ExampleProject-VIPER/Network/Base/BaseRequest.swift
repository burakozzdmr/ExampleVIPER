//
//  BaseRequest.swift
//  ExampleProject-VIPER
//
//  Created by Burak Özdemir on 14.07.2026.
//

import Foundation

class BaseRequest {
    var baseURL: String { NetworkConstants.baseURL }
    var path: String { "" }
    var fullEndpoint: String { baseURL + path }
    var method: HTTPMethod { .GET }
    var headers: [String: String] { [NetworkConstants.Headers.contentType: NetworkConstants.Headers.applicationJson] }
    var body: Data?
}
