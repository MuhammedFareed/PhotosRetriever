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
    
    func loadImage(from url: URL) {
        self.image = UIImage(named: "placeholder")
        currentUrl = url
        if let cachedImage = imageCache?.getImage(for: url) {
            self.image = cachedImage
            return
        }
        let delay = 0.1 // in seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.imageLoader?.loadImage(from: url) { [weak self] (result) in
                guard let self = self, url == self.currentUrl else { return }
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        guard let resizedImage = image.resizedImage(maxWidth: self.frame.width) else {
                            return
                        }
                        self.image = resizedImage
                        self.imageCache?.setImage(resizedImage, for: url)
                    }
                case .failure(let error):
                    print("Failed to load image: \(error.localizedDescription)")
                }
            }
        }
    }
}
