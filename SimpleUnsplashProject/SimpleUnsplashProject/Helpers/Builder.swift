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
    func createDetailScreen(router: RouterProtocol,
                              parameters: [String: String],
                              dataPicture: UIImage?) -> UIViewController
}

class Builder: BuilderProtocol {
    let dataStoreManager = DataStoreManager()
    
    func createSearchScreen(router: RouterProtocol) -> UIViewController {
        let view = SearchViewController()
        let presenter = SearchPresenter(view: view,
                                        router: router)
        view.presenter = presenter
        return view
    }
    
    func createFavoriteScreen(router: RouterProtocol) -> UIViewController {
        let view = FavouritePicturesViewController()
        return view
    }
    
    func createDetailScreen(router: RouterProtocol, parameters: [String : String], dataPicture: UIImage?) -> UIViewController {
        let view = DetailsViewController()
        return view
    }
}
