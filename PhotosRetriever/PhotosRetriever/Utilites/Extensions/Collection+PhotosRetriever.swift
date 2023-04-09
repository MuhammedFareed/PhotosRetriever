//
//  Collection+PhotosRetriever.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
            return indices.contains(index) ? self[index] : nil
    }
}
