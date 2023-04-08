//
//  PageableRequestProtocol.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import Foundation

protocol PageableRequest: APIRequestProtocol {
    var pagingInfo: (pageNumber: Int, pageSize: Int) { get }
}
