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
    private var photos: [PhotoModel] = []
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
                    self?.photos = photos
                    self?.view.success()
                case .failure(let error):
                    self?.view.failure(error: error)
                }
            }
        }
    }
    func getPictures() -> [PhotoModel] {
        return photos
    }
    func selectPhoto(photo: PhotoModel) {
        router.showDetailedView(from: photo)
    }
}
