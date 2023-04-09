//
//  PhotoDetailsViewController.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    @IBOutlet weak var photoImageView: DownloaderImageView!
    
    private var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let currentPhoto = photo, let photoURL = URL(string: currentPhoto.downloadUrl) else {
            return
        }
        photoImageView.loadImage(from: photoURL, completion: { [weak self] image in
            guard let returnedImage = image else {
                return
            }
            
        })
    }
    
    func setPhoto(_ photo: Photo) {
        self.photo = photo
    }
    
}

extension PhotoDetailsViewController: Storyboardable {}
