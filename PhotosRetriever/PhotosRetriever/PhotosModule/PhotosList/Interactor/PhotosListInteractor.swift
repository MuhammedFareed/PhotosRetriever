//
//  PhotosListInteractor.swift
//  PhotosRetriever
//
//  Created by Muhammad Fareed on 09/04/2023.
//

import Foundation

protocol PhotosListInteractorProtocol {
    func fetchPhotos()
    func didSelectItemAt(_ index: Int)
}

protocol PhotosListInteractorDelegateProtocol: AnyObject {
    func didFinishBuildingItems(_ items: [PhotoListItem])
    func photoSelected(_ photo: Photo)
}

class PhotosListInteractor: PhotosListInteractorProtocol {
    let repository: PhotosRepositoryProtocol
    let itemListBuilder: PhotosListBuilderProtocol
    
    var listItems: [PhotoListItem] = []
    var currentPageNumber = 1
    weak var delegate: PhotosListInteractorDelegateProtocol?
    
    init(repository: PhotosRepositoryProtocol = PhotosRepository(), itemListBuilder: PhotosListBuilderProtocol = PhotosListBuilder()) {
        self.repository = repository
        self.itemListBuilder = itemListBuilder
    }
    
    func fetchPhotos() {
        repository.fetchPhotosList(pageNumber: currentPageNumber, onSuccess: { [weak self] fetchedPhotos in
            guard let self = self else { return }
            
            self.currentPageNumber += 1
            let listItems = self.itemListBuilder.buildList(for: fetchedPhotos)
            self.listItems.append(contentsOf: listItems)
            self.delegate?.didFinishBuildingItems(self.listItems)
        }, onFailure: { error in
            // handle failure case
        })
    }
    
    func didSelectItemAt(_ index: Int) {
        guard let item = listItems[safe: index],
              item.kind == .photo, let photo = item.photo else {
            return
        }
        delegate?.photoSelected(photo)
    }
}
