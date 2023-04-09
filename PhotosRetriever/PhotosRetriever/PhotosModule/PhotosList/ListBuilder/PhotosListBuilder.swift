//
//  PhotosListBuilder.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import Foundation

protocol PhotosListBuilderProtocol {
    func buildList(for photos: [Photo]) -> [ListItem]
}

class PhotosListBuilder: PhotosListBuilderProtocol {
    func buildList(for photos: [Photo]) -> [ListItem] {
        var listItems: [ListItem] = []
        for (index, photo) in photos.enumerated() {
            // Every 5th photo, add an ad list item
            if (index + 1) % 5 == 0 {
                listItems.append(ListItem(kind: .ad, photo: nil))
            } else {
                listItems.append(ListItem(kind: .photo, photo: photo))
            }
        }
        return listItems
    }
}
