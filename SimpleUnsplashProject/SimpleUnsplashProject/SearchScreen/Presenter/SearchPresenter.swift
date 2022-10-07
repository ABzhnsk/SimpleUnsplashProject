//
//  SearchPresenter.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 07.10.2022.
//

import Foundation

class SearchPresenter {
    private let view: SearchViewProtocol
    private let router: RouterProtocol
    private var photos: [Photos] = []
    private var page = 1

    init(view: SearchViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        fetchData(with: "random")
    }
    
    func fetchData(with query: String) {
        NetworkDataFetch.shared.fetchPhoto(api: .getSearch(query: query, page: self.page)) { [weak self] result in
            switch result {
            case .success(let photos):
                self?.photos = photos.results
                self?.view.success()
                self?.page += 1
            case .failure(let error):
                self?.view.failure(error: error)
            }
        }
    }
    func getPictures() -> [Photos] {
        return photos
    }
}
