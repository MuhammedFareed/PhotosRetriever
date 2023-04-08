//
//  PhotosDataStoreProtocol.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import Foundation

protocol PhotosDataStoreProtocol: AnyObject {
    func fetchPhotosList(onSuccess: @escaping ([Photo]) -> Void, onFailure: @escaping (Error?) -> Void)
}
