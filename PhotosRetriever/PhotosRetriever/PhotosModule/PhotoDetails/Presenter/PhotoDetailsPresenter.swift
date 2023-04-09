//
//  PhotoDetailsPresenter.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import UIKit

protocol PhotosDetailsPresenterProtocol: AnyObject {
//    func attachView(_ view: PhotosListViewControllerProtocol)
    func detectColorIn(_ image: UIImage) -> UIColor?
}

class PhotosDetailsPresenter: PhotosDetailsPresenterProtocol {
    private let colorDetector: DominantColorDetectorProtocol
//    private weak var view: PhotosListViewControllerProtocol?
    
    init(withDetector detector: DominantColorDetectorProtocol = DominantColorDetector()) {
        self.colorDetector = detector
    }
    
//    func attachView(_ view: PhotosListViewControllerProtocol) {
//        self.view = view
//    }
    
    func detectColorIn(_ image: UIImage) -> UIColor? {
        return colorDetector.getDominantColor(from: image)
    }
}
