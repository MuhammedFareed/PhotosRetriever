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
        photosListTableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.reuseIdentifier)
        photosListTableView.dataSource = self
        photosListTableView.delegate = self
    }
}

extension PhotosListViewController: PhotosListViewControllerProtocol {
    func displayItems() {
        photosListTableView.reloadData()
    }
    
    func showItemDetails(_ item: ListItem) {
        
    }
}

extension PhotosListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = presenter?.getItem(at: indexPath.row) else {
            return UITableViewCell()
        }
        switch item.kind {
        case .ad:
            let adCell = UITableViewCell()
            adCell.textLabel?.text = item.adMessage
            return adCell
        case .photo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.reuseIdentifier) as? PhotoTableViewCell,
                  let photo = item.photo else {
                return UITableViewCell()
            }
            cell.configure(withPhoto: photo)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath.row)
    }
}

