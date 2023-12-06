//
//  APIRequestProtocol.swift
//  GithupReposApp
//
//  Created by Muhammad Fareed on 13/05/2022.
//

import Foundation

protocol APIRequestProtocol {
    var path: String { get }
    var headers: [String: String] { get }
    var httpMethod: HTTPMethods { get }
    var decodingStrategy: JSONDecoder.KeyDecodingStrategy { get }
}
