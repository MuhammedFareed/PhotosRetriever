//
//  PhotosListViewController.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import UIKit

protocol PhotosListViewControllerProtocol {
    func displayItems()
    func showItemDetails(_ item: ListItem)
}

class PhotosListViewController: UIViewController {

    @IBOutlet weak var photosListTableView: UITableView!
    private var presenter: PhotosListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        presenter = PhotosListPresenter()
        presenter?.fetchPhotos()
    }
    
    private func setupTableView() {
        
    }
}

extension PhotosListViewController: PhotosListViewControllerProtocol {
    func displayItems() {
        photosListTableView.reloadData()
    }
    
    func showItemDetails(_ item: ListItem) {
        
    }
}

