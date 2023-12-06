//
//  APIClientProtocol.swift
//  GithupReposApp
//
//  Created by Muhammad Fareed on 13/05/2022.
//

import Foundation

typealias NetworkSuccess = (Codable) -> Void
typealias NetworkFailure = (Error) -> Void

protocol RESTAPICaller {
    func call<T: Codable>(url: String,withRequest request: APIRequestProtocol, responseType: T.Type, onSuccess: @escaping NetworkSuccess, onFailure: @escaping NetworkFailure)
}

protocol RESTAPIClient {
    var caller: RESTAPICaller { get set }
    var baseURL: String { get set }
    func start<T: Codable>(withRequest request: APIRequestProtocol, responseType: T.Type, onSuccess: @escaping NetworkSuccess, onFailure: @escaping NetworkFailure)
}

extension RESTAPIClient {
    func start<T: Codable>(withRequest request: APIRequestProtocol, responseType: T.Type, onSuccess: @escaping NetworkSuccess, onFailure: @escaping NetworkFailure) {
        caller.call(url: baseURL, withRequest: request, responseType: responseType, onSuccess: onSuccess, onFailure: onFailure)
    }
}

extension URLSession: RESTAPICaller {
    func call<T>(url: String, withRequest request: APIRequestProtocol, responseType: T.Type, onSuccess: @escaping NetworkSuccess, onFailure: @escaping NetworkFailure) where T : Decodable, T : Encodable {
        let url = URL(string: "\(url)/\(request.path)")
        let urlRequest = NSMutableURLRequest()
        urlRequest.url = url
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        let task = dataTask(with: urlRequest as URLRequest, completionHandler: { data, response, error in
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
