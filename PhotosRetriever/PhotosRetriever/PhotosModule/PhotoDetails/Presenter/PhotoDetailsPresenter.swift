//
//  PhotoDetailsPresenter.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import UIKit

protocol PhotosDetailsPresenterProtocol: AnyObject {
    func detectColorIn(_ image: UIImage) -> UIColor?
}

class PhotosDetailsPresenter: PhotosDetailsPresenterProtocol {
    private let colorDetector: DominantColorDetectorProtocol
    
    init(withDetector detector: DominantColorDetectorProtocol = DominantColorDetector()) {
        self.colorDetector = detector
    }
    
    func detectColorIn(_ image: UIImage) -> UIColor? {
        return colorDetector.getDominantColor(from: image)
    }
}
