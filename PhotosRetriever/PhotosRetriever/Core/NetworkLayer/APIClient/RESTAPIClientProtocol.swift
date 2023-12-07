//
//  APIClientProtocol.swift
//  GithupReposApp
//
//  Created by Muhammad Fareed on 13/05/2022.
//

import Foundation

struct RESTAPIResponse<T: Codable> {
    let result: Result<T, NetworkError>
}

protocol RESTAPICaller {
    func call<T: Codable>(url: String, withRequest request: APIRequestProtocol) async -> RESTAPIResponse<T>
}

protocol RESTAPIClient {
    var caller: RESTAPICaller { get set }
    var baseURL: String { get set }
    func start<T: Codable>(withRequest request: APIRequestProtocol) async -> RESTAPIResponse<T>
}

extension RESTAPIClient {
    func start<T: Codable>(withRequest request: APIRequestProtocol) async -> RESTAPIResponse<T> {
        let result: RESTAPIResponse<T> = await caller.call(url: baseURL, withRequest: request)
        return result
    }
}

extension URLSession: RESTAPICaller {
    func call<T: Codable>(url: String, withRequest request: APIRequestProtocol) async -> RESTAPIResponse<T> {
        guard let url = URL(string: "\(url)/\(request.path)") else {
            return RESTAPIResponse(result: .failure(NetworkError.invalidURL))
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        do {
            let (data,_) = try await data(for: urlRequest)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = request.decodingStrategy
            let response = try decoder.decode(T.self, from: data)
            return RESTAPIResponse(result: .success(response))
        } catch {
            return RESTAPIResponse(result: .failure(NetworkError.requestFailed(error: error)))
        }
    }
}
