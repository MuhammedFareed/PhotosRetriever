//
//  APIClientProtocol.swift
//  GithupReposApp
//
//  Created by Muhammad Fareed on 13/05/2022.
//

import Foundation

typealias NetworkSuccess = (Codable) -> Void
typealias NetworkFailure = (Error) -> Void

protocol APIClient {
    var session: URLSession { get set }
    var baseURL: String { get set }
    func start<T: Codable>(withRequest request: APIRequestProtocol, responseType: T.Type, onSuccess: @escaping NetworkSuccess, onFailure: @escaping NetworkFailure)
}

extension APIClient {
    func start<T: Codable>(withRequest request: APIRequestProtocol, responseType: T.Type, onSuccess: @escaping NetworkSuccess, onFailure: @escaping NetworkFailure) {
        let url = URL(string: "\(baseURL)/\(request.path)")
        let urlRequest = NSMutableURLRequest()
        urlRequest.url = url
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: { data, response, error in
            if error != nil {
                onFailure(error!)
            } else {
                if let returnedData = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = request.decodingStrategy
                        let returnedResponse = try decoder.decode(T.self, from: returnedData)
                        onSuccess(returnedResponse)
                    } catch {
                        onFailure(NetworkError.decodingError)
                    }
                    onSuccess(returnedData)
                } else {
                    onFailure(NetworkError.emptyResponse)
                }
            }
        })
        task.resume()
    }
}

