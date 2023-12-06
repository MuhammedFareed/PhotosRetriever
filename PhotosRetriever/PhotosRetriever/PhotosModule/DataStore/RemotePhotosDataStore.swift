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
        apiClient.start(withRequest: PhotosRequest.listPhotos(pageNumber: pageNumber), responseType: [Photo].self, onSuccess: { photos in
            if let photosList = photos as? [Photo] {
                onSuccess(photosList)
            } else {
                onFailure(NetworkError.decodingError)
            }
        }, onFailure:  { error in
            onFailure(error)
        })
    }
}
