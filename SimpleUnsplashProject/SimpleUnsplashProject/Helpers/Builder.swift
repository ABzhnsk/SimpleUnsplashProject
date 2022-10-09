//
//  Builder.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 07.10.2022.
//

import UIKit

protocol BuilderProtocol: AnyObject {
    func createSearchScreen(router: RouterProtocol) -> UIViewController
    func createFavoriteScreen(router: RouterProtocol) -> UIViewController
    func createDetailScreenFrom(model: PhotoModel) -> UIViewController
}

class Builder: BuilderProtocol {
    let dataStoreManager = CoreDataManager()
    
    func createSearchScreen(router: RouterProtocol) -> UIViewController {
        let view = SearchViewController()
        let presenter = SearchPresenter(view: view,
                                        router: router)
        view.presenter = presenter
        return view
    }
    
    func createFavoriteScreen(router: RouterProtocol) -> UIViewController {
        let view = FavouritePicturesViewController()
        let presenter = FavouritePicturesPresenter(view: view, router: router, coreDataManager: dataStoreManager)
        view.presenter = presenter
        return view
    }
    
    func createDetailScreenFrom(model: PhotoModel) -> UIViewController {
        let view = DetailsViewController()
        let presenter = DetailsViewPresenter(view: view,
                                             dataStorageManager: dataStoreManager,
                                             model: model)
        view.presenter = presenter
        return view
    }
}
