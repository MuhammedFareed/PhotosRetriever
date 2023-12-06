//
//  DownloaderImageView.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import UIKit

class DownloaderImageView: UIImageView {
    
    private var imageLoader: ImageDownloaderProtocol? = ImageDownloader()
    private var imageCache: ImageCacherProtocol? = ImageCacher.shared
    private var currentUrl: URL?
    
    func loadImage(from url: URL, completion: ((UIImage?) -> Void)? = nil) {
        self.image = UIImage(named: "placeholder")
        currentUrl = url
        if let cachedImage = imageCache?.getImage(for: url) {
            DispatchQueue.main.async { [weak self] in
                self?.image = cachedImage
            }
            completion?(cachedImage)
            return
        }
        imageLoader?.loadImage(from: url) { [weak self] (result) in
            guard let self = self, url == self.currentUrl else { return }
            switch result {
            case .success(let image):
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                    guard let resizedImage = image.resizedImage(maxWidth: self.frame.width) else {
                        return
                    }
                    self.image = resizedImage
                    self.imageCache?.setImage(resizedImage, for: url)
                }
                completion?(image)
            case .failure(let error):
                print("Failed to load image: \(error.localizedDescription)")
                completion?(nil)
            }
        }
    }
}
