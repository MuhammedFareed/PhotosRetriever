//
//  Photo.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import Foundation

struct Photo: Codable {
    let id: String
    let author: String
    let url: String
    let width: Int
    let height: Int
}
