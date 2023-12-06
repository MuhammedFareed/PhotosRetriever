//
//  PhotoTableViewCell.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var authorNameLabel: UILabel!
    @IBOutlet private weak var photoImageView: DownloaderImageView!
    
    static let reuseIdentifier: String = String(describing: PhotoTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        addDropShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        photoImageView.image = nil
    }
    
    func configure(withPhoto photo: Photo)  {
        authorNameLabel.text = "Author: \(photo.author)"
        if let url = URL(string: photo.downloadUrl) {
            photoImageView.loadImage(from: url)
        }
    }
    
    private func addDropShadow() {
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = containerView.bounds
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = CGSize(width: 2, height: 2)
        shadowLayer.shadowOpacity = 0.5
        shadowLayer.shadowRadius = 4

        // Create the path for the shadow layer
        let path = UIBezierPath(rect: containerView.bounds)
        shadowLayer.path = path.cgPath

        // Add the shadow layer to the view's layer
        containerView.layer.insertSublayer(shadowLayer, at: 0)
    }
    
}
