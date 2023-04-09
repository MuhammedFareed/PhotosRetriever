//
//  ListItem.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import Foundation

struct ListItem {
    enum Kind {
        case photo
        case ad
    }
    var kind: Kind
    let adMessage: String = "This is an ad"
    var photo: Photo?
}
