//
//  ImageCacher.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import UIKit

protocol ImageCacherProtocol {
    func getImage(for url: URL) -> UIImage?
    func setImage(_ image: UIImage, for url: URL)
}

class NSCacheImageCacher: ImageCacherProtocol {
    
    static let shared = NSCacheImageCacher()
    
    private let cache = NSCache<NSURL, UIImage>()
    
    private init() {}
    
    func getImage(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }
    
    func setImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
}
