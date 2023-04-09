//
//  PhotoDetailsViewController.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    @IBOutlet weak var photoImageView: DownloaderImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension PhotoDetailsViewController: Storyboardable {}
