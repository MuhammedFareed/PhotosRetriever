//
//  UIImageView+PhotosRetriever.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import UIKit

extension UIImage {

    func resizedImage(maxWidth: CGFloat) -> UIImage? {
        let scale = maxWidth / self.size.width
        let newHeight = self.size.height * scale
        let newSize = CGSize(width: maxWidth, height: newHeight)
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let image = renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
        return image
    }

}
