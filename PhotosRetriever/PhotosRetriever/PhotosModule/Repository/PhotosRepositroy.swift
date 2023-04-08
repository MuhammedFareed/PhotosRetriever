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
