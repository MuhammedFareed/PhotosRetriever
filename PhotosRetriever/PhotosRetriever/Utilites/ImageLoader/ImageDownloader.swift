//
//  ImageLoader.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import UIKit

enum ImageLoadingError: Error {
    case invalidData
}

protocol ImageDownloaderProtocol {
    func loadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void)
}

class ImageDownloader: ImageDownloaderProtocol {
    
    private let session: URLSession
    private var currentTask: URLSessionDataTask?
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func loadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let runningTaskURL = currentTask?.originalRequest?.url, runningTaskURL == url {
            return
        }
        currentTask?.cancel()
        currentTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(ImageLoadingError.invalidData))
                return
            }
            completion(.success(image))
        }
        currentTask?.resume()
    }
}
