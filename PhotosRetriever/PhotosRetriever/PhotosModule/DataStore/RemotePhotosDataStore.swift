//
//  RemotePhotosDataStore.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import Foundation

class RemotePhotosDataStore: PhotosDataStoreProtocol {
    var apiClient: RESTAPIClient
    
    init(withAPIClient apiClient: RESTAPIClient = PhotosRESTAPIClient()) {
        self.apiClient = apiClient
    }
    
    func fetchPhotosList(pageNumber: Int, onSuccess: @escaping ([Photo]) -> Void, onFailure: @escaping (Error?) -> Void) {
        let request = PhotosRequest.listPhotos(pageNumber: pageNumber)
        Task {
            let response: RESTAPIResponse<[Photo]> = await apiClient.start(withRequest: request)
            switch response.result {
            case let .success(photos):
                onSuccess(photos)
            case let .failure(error):
                onFailure(error)
            }
        }
    }
}
