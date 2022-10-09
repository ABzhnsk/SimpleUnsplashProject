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
    private var photos: [PhotoModel] = []
    
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
    func getPhotos() -> [PhotoModel] {
        return photos
    }
    func selectPhoto(from model: PhotoModel) {
        router.showDetailedViewFromFavouriteView(with: model)
    }
    func deleteFavouritesPhoto(from model: PhotoModel, indexPath: IndexPath) {
        coreDataManager.deletePhotoCoreData(photoViewModel: model) { result in
            switch result {
            case .success(let success):
                if success {
                    photos.remove(at: indexPath.row)
                }
            case.failure(let error):
                view.errorCoreData(with: error.localizedDescription)
            }
        }
    }
    
    private func createPhotoModel(photoCoreData: FavouritePhoto) -> PhotoModel {
        return PhotoModel(id: photoCoreData.id ?? "",
                          imageUrl: photoCoreData.imageUrl ?? "",
                          userName: photoCoreData.userName ?? "",
                          userLocation: photoCoreData.userLocation ?? "",
                          createdAt: photoCoreData.createdAt ?? "",
                          downloads: Int(photoCoreData.downloads))
    }
}
