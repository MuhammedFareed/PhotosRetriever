//
//  PhotosListPresenter.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import Foundation

protocol PhotosListPresenterProtocol: AnyObject {
    func attachView(_ view: PhotosListViewControllerProtocol)
    func fetchPhotos()
    func didDisplayLastItem()
    func numberOfItems() -> Int
    func getItem(at index: Int) -> PhotoListItem?
    func didSelectItem(at index: Int)
}

class PhotosListPresenter: PhotosListPresenterProtocol {
    private let interactor: PhotosListInteractorProtocol
    private var listItems: [PhotoListItem] = []
    private weak var view: PhotosListViewControllerProtocol?
    
    init(withInteractor interactor: PhotosListInteractorProtocol = PhotosListInteractor()) {
        self.interactor = interactor
        (interactor as? PhotosListInteractor)?.delegate = self
    }
    
    func attachView(_ view: PhotosListViewControllerProtocol) {
        self.view = view
    }
    
    func fetchPhotos() {
        interactor.fetchPhotos()
    }
    
    func didDisplayLastItem() {
        interactor.fetchPhotos()
    }
    
    func numberOfItems() -> Int {
        return listItems.count
    }
    
    func getItem(at index: Int) -> PhotoListItem? {
        guard let item = listItems[safe: index] else {
            return nil
        }
        return item
    }
    
    func didSelectItem(at index: Int) {
        interactor.didSelectItemAt(index)
    }
    
    private func displayItems(_ items: [PhotoListItem]) {
        listItems = items
        view?.displayItems()
    }
    
    private func showDetailsOf(_ photo: Photo) {
        view?.showPhotoDetails(photo)
    }
}

extension PhotosListPresenter: PhotosListInteractorDelegateProtocol {
    func didFinishBuildingItems(_ items: [PhotoListItem]) {
        displayItems(items)
    }
    
    func photoSelected(_ photo: Photo) {
        showDetailsOf(photo)
    }
}
