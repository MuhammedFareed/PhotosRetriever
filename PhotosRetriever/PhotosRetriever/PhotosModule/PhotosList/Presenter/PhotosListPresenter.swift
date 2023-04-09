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
    func displayItems(_ items: [ListItem])
    func didDisplayLastItem()
    func numberOfItems() -> Int
    func getItem(at index: Int) -> ListItem?
    func didSelectItem(at index: Int)
}

class PhotosListPresenter: PhotosListPresenterProtocol {
    private let interactor: PhotosListInteractorProtocol
    private var listItems: [ListItem] = []
    private weak var view: PhotosListViewControllerProtocol?
    
    init(withInteractor interactor: PhotosListInteractorProtocol = PhotosListInteractor()) {
        self.interactor = interactor
        (interactor as? PhotosListInteractor)?.presenter = self
    }
    
    func attachView(_ view: PhotosListViewControllerProtocol) {
        self.view = view
    }
    
    func fetchPhotos() {
        interactor.fetchPhotos()
    }
    
    func displayItems(_ items: [ListItem]) {
        listItems = items
        view?.displayItems()
    }
    
    func didDisplayLastItem() {
        interactor.fetchPhotos()
    }
    
    func numberOfItems() -> Int {
        return listItems.count
    }
    
    func getItem(at index: Int) -> ListItem? {
        guard let item = listItems[safe: index] else {
            return nil
        }
        return item
    }
    
    func didSelectItem(at index: Int) {
        return 
    }
}
