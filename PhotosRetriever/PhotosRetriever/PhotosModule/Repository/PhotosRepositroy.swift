//
//  PhotosRepositroyProtocol.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import Foundation

enum PhotosRepositoryError: Error {
    case noData
}

protocol PhotosRepositoryProtocol: AnyObject {
    func fetchPhotosList(pageNumber: Int, onSuccess: @escaping ([Photo]) -> Void, onFailure: @escaping (PhotosRepositoryError) -> Void)
}

class PhotosRepository: PhotosRepositoryProtocol {
    let remoteDataStore: PhotosDataStoreProtocol
    
    init(withRemoteDataStore remoteDataStore: PhotosDataStoreProtocol = RemotePhotosDataStore()) {
        self.remoteDataStore = remoteDataStore
    }
    
    func fetchPhotosList(pageNumber: Int, onSuccess: @escaping ([Photo]) -> Void, onFailure: @escaping (PhotosRepositoryError) -> Void) {
        remoteDataStore.fetchPhotosList(pageNumber: pageNumber, onSuccess: onSuccess, onFailure: { error in
            onFailure(PhotosRepositoryError.noData)
        })
    }
}
