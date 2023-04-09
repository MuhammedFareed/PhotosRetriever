//
//  PhotosAPIClient.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import Foundation

class PhotosAPIClient: APIClient {
    var baseURL: String = "https://picsum.photos/v2/"
    var session: URLSession
    
    init(withSession session: URLSession = URLSession.shared) {
        self.session = session
    }
}
