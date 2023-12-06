//
//  PhotosAPIClient.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import Foundation

class PhotosRESTAPIClient: RESTAPIClient {
    var baseURL: String = "https://picsum.photos/v2/"
    var caller: RESTAPICaller
    
    init(withCaller caller: RESTAPICaller = URLSession.shared) {
        self.caller = caller
    }
}
