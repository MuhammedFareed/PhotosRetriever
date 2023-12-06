//
//  PhotoDetailsViewController.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    @IBOutlet private weak var photoImageView: DownloaderImageView!
    
    private var photo: Photo?
    private var presenter: PhotosDetailsPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = PhotosDetailsPresenter()
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
            guard let color = self?.presenter?.detectColorIn(returnedImage) else {
                return
            }
            self?.view.backgroundColor = color
        })
    }
    
    func setPhoto(_ photo: Photo) {
        self.photo = photo
    }
    
}

extension PhotoDetailsViewController: Storyboardable {}
