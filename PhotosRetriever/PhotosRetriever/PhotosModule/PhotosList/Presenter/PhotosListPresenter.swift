//
//  PhotosListPresenter.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import Foundation

protocol PhotosListPresenterProtocol {
    func fetchPhotos()
    func getItem(at index: Int) -> ListItem?
    func didSelectItem(at index: Int)
}

class PhotosListPresenter: PhotosListPresenterProtocol {
    private let interactor: PhotosListInteractorProtocol
    private var listItems: [ListItem] = []
    
    init(withInteractor interactor: PhotosListInteractorProtocol = PhotosListInteractor()) {
        self.interactor = interactor
    }
    
    func fetchPhotos() {
        interactor.fetchPhotos()
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
