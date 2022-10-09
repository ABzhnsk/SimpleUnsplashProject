//
//  SearchPresenter.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 07.10.2022.
//

import UIKit

class SearchPresenter {
    private let view: SearchViewProtocol
    private let router: RouterProtocol
    private var resultsModel: [ResultsModel] = []
    private var photoModel: [PhotoModel] = []
    private var page = 30

    init(view: SearchViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        fetchData(with: "")
    }
    
    func fetchData(with query: String) {
        NetworkDataFetch.shared.fetchPhoto(api: .getSearch(query: query, page: self.page)) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let photos):
                    let photoModel = photos.compactMap { self?.createPhotoModel(from: $0) }
                    self?.photoModel = photoModel
                    self?.view.success()
                case .failure(let error):
                    self?.view.failure(error: error)
                }
            }
        }
    }
    func getPictures() -> [PhotoModel] {
        return photoModel
    }
    func selectPhoto(from model: PhotoModel) {
        router.showDetailedViewFromSearchView(with: model)
    }
    
    private func createPhotoModel(from results: ResultsModel) -> PhotoModel {
        return PhotoModel(id: results.id,
                          imageUrl: results.imageUrl,
                          userName: results.userName,
                          userLocation: results.userLocation,
                          createdAt: results.createdAt,
                          downloads: results.downloads)
    }
}
