//
//  PhotosListViewController.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import UIKit

protocol PhotosListViewControllerProtocol: UIViewController {
    func displayItems()
    func showPhotoDetails(_ photo: Photo)
}

class PhotosListViewController: UIViewController {

    @IBOutlet weak var photosListTableView: UITableView!
    private var presenter: PhotosListPresenterProtocol?
    private var currentContentOffset: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        presenter = PhotosListPresenter()
        presenter?.attachView(self)
        presenter?.fetchPhotos()
    }
    
    private func setupTableView() {
        photosListTableView.register(
            UINib(nibName: PhotoTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: PhotoTableViewCell.reuseIdentifier)
        photosListTableView.dataSource = self
        photosListTableView.delegate = self
    }
}

extension PhotosListViewController: PhotosListViewControllerProtocol {
    func displayItems() {
        DispatchQueue.main.async { [weak self] in 
            self?.photosListTableView.reloadData()
            self?.photosListTableView.layoutIfNeeded()
            guard let contentOffset = self?.currentContentOffset else {
                return
            }
            self?.photosListTableView.setContentOffset(contentOffset, animated: false)
        }
    }
    
    func showPhotoDetails(_ photo: Photo) {
        let detailsViewController = PhotoDetailsViewController.instantiate()
        detailsViewController.setPhoto(photo)
        navigationController?.pushViewController(detailsViewController, animated: true)
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let numberOfItems = presenter?.numberOfItems() ?? 0
        guard indexPath.row == numberOfItems - 1 else {
            return
        }
        currentContentOffset = tableView.contentOffset
        presenter?.didDisplayLastItem()
    }
}

