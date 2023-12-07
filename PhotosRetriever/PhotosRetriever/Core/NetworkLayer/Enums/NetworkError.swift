//
//  NetworkError.swift
//  GithupReposApp
//
//  Created by Muhammad Fareed on 13/05/2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(error: Error)
    case emptyResponse
    case decodingError
}
