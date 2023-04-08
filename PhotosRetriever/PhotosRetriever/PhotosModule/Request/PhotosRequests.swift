//
//  PhotosRequests.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import Foundation

enum PhotosRequest: APIRequestProtocol {
    case listPhotos(pageNumber: Int)
    var path: String {
        switch self {
        case let .listPhotos(pageNumber):
            return "list?page=\(pageNumber)&limit=10"
        }
    }
    
    var headers: [String : String] {
        return [:]
    }
    
    var httpMethod: HTTPMethods {
        return .get
    }
    
    var decodingStrategy: JSONDecoder.KeyDecodingStrategy {
        return .convertFromSnakeCase
    }
}
