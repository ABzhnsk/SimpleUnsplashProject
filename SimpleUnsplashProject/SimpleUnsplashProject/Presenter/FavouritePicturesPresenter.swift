//
//  FavouritePicturesPresenter.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 09.10.2022.
//

import Foundation

class FavouritePicturesPresenter {
    private let view: FavouritePicturesViewProtocol
    private let router: RouterProtocol
    private let coreDataManager: CoreDataManager
    private var photos: [Photo] = []
    
    init(view: FavouritePicturesViewProtocol,
         router: RouterProtocol,
         coreDataManager: CoreDataManager)
    {
        self.view = view
        self.router = router
        self.coreDataManager = coreDataManager
    }
    
    func fetchFavouritePictures() {
        coreDataManager.fetchPhotoCoreData { [weak self] result in
            switch result {
            case .success(let photoCoreData):
                let favouritePhotos = photoCoreData.compactMap { self?.createPhotoModel(photoCoreData: $0) }
                self?.photos = favouritePhotos
                self?.view.success()
            case .failure(let error):
                self?.view.errorCoreData(with: error.localizedDescription)
            }
        }
    }
    func getPhotos() -> [Photo] {
        return photos
    }
    
    private func createPhotoModel(photoCoreData: FavouritePhoto) -> Photo {
        return Photo(id: photoCoreData.id ?? "",
                     imageUrl: photoCoreData.imageUrl ?? "",
                     userName: photoCoreData.userName ?? "",
                     userLocation: photoCoreData.userLocation ?? "",
                     createdAt: photoCoreData.createdAt ?? "",
                     downloads: Int(photoCoreData.downloads))
    }
}
