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
        /// I didn't want to make the signature of this function to use modern concurrency aka async/await, since it's a protocol method for DataStores and I didn't want to enforce modern concurrency on it, as local data stores for example might not user modern concurrency, so instead I used Tasks.
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
