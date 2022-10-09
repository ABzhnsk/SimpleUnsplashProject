//
//  Router.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 07.10.2022.
//

import UIKit

protocol RouterMain {
    var tabBarController: UITabBarController? { get set }
    var builder: BuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func setupTabBar()
    func showDetailedViewFromSearchView(with searchPhoto: PhotoModel)
    func showDetailedViewFromFavouriteView(with favouritePhoto: PhotoModel)
}

class Router: RouterProtocol {
    var tabBarController: UITabBarController?
    var builder: BuilderProtocol?
    
    private var searchNavigationController = UINavigationController()
    private var favoriteNavigationController = UINavigationController()
    
    init(tabBarController: UITabBarController, builder: BuilderProtocol) {
        self.tabBarController = tabBarController
        self.builder = builder
    }
    
    private func wrappedInNavigationController(image: UIImage,
                                               rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.image = image
        navigationController.navigationBar.tintColor = .black
        return navigationController
    }
    
    public func setupTabBar() {
        if let tabBarController = tabBarController {
            let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .large)
            let imageSearch = UIImage(systemName: "magnifyingglass",
                                      withConfiguration: configuration)
            let imageLike = UIImage(systemName: "suit.heart",
                                    withConfiguration: configuration)
            guard let searchViewController = builder?.createSearchScreen(router: self),
                  let favoriteViewController = builder?.createFavoriteScreen(router: self)
            else { return }
            searchNavigationController = wrappedInNavigationController(image: imageSearch!,
                                                                       rootViewController: searchViewController)
            favoriteNavigationController = wrappedInNavigationController(image: imageLike!,
                                                                         rootViewController: favoriteViewController)
            tabBarController.viewControllers = [searchNavigationController, favoriteNavigationController]
            tabBarController.tabBar.tintColor = .black
        }
    }
    public func showDetailedViewFromSearchView(with searchPhoto: PhotoModel) {
        guard let detailViewController = builder?.createDetailScreenFrom(model: searchPhoto)
        else { return }
        searchNavigationController.pushViewController(detailViewController, animated: true)
    }
    public func showDetailedViewFromFavouriteView(with favouritePhoto: PhotoModel) {
        guard let detailViewController = builder?.createDetailScreenFrom(model: favouritePhoto)
        else { return }
        favoriteNavigationController.pushViewController(detailViewController, animated: true)
    }
}
