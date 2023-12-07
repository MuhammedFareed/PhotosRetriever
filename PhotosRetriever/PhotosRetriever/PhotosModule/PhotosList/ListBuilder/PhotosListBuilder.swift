//
//  PhotosListBuilder.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import Foundation

protocol PhotosListBuilderProtocol {
    func buildList(for photos: [Photo]) -> [PhotoListItem]
}

class PhotosListBuilder: PhotosListBuilderProtocol {
    func buildList(for photos: [Photo]) -> [PhotoListItem] {
        var listItems: [PhotoListItem] = []
        for (index, photo) in photos.enumerated() {
            // Every 5th photo, add an ad list item
            if (index + 1) % 5 == 0 {
                listItems.append(PhotoListItem(kind: .ad, photo: nil))
            } else {
                listItems.append(PhotoListItem(kind: .photo, photo: photo))
            }
        }
        return listItems
    }
}
