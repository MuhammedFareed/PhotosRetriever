//
//  RemotePhotosDataStore.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import Foundation

class RemotePhotosDataStore: PhotosDataStoreProtocol {
    var apiClient: APIClient
    
    init(withAPIClient apiClient: APIClient = PhotosAPIClient()) {
        self.apiClient = apiClient
    }
    
    func fetchPhotosList(onSuccess: @escaping ([Photo]) -> Void, onFailure: @escaping (Error?) -> Void) {
        apiClient.start(withRequest: PhotosRequest.listPhotos(pageNumber: 1), responseType: [Photo].self, onSuccess: { photos in
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
