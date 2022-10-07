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
    func showDetailedViewFrom(searchPhoto: Photos, image: UIImage)
    func showDetailedViewFrom(favoritePhoto: FavouritePhoto, image: UIImage)
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
                                               tabBarItemTitle: String,
                                               rootViewController: UIViewController) -> UINavigationController {
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.backgroundColor = .white
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.image = image
        navigationController.tabBarItem.title = tabBarItemTitle
        navigationController.navigationBar.standardAppearance = appearence
        navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance
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
                                                                       tabBarItemTitle: "Search",
                                                                       rootViewController: searchViewController)
            favoriteNavigationController = wrappedInNavigationController(image: imageLike!,
                                                                         tabBarItemTitle: "Favorites",
                                                                         rootViewController: favoriteViewController)
            tabBarController.viewControllers = [searchNavigationController, favoriteNavigationController]
            tabBarController.tabBar.backgroundColor = .white
            tabBarController.tabBar.barStyle = .default
            tabBarController.tabBar.tintColor = .black
        }
    }
    public func showDetailedViewFrom(searchPhoto: Photos, image: UIImage) {
        var parameters = [String: String]()
        parameters["userName"] = searchPhoto.user?.name
        parameters["userLocation"] = searchPhoto.user?.location
        parameters["createdAt"] = searchPhoto.createdAt
        parameters["countLikes"] = Formatter.currency.string(from: NSNumber(value: searchPhoto.likes ?? 0))
        guard let detailViewController = builder?.createDetailScreen(router: self,
                                                                     parameters: parameters,
                                                                     dataPicture: image)
        else { return }
        searchNavigationController.pushViewController(detailViewController, animated: true)
    }
    public func showDetailedViewFrom(favoritePhoto: FavouritePhoto, image: UIImage) {
        var parameters = [String: String]()
        parameters["userName"] = favoritePhoto.userName
        parameters["userLocation"] = favoritePhoto.userLocation
        parameters["createdAt"] = favoritePhoto.createdAt
        parameters["countLikes"] = Formatter.currency.string(from: NSNumber(value: favoritePhoto.countLikes))
        
        guard let detailViewController = builder?.createDetailScreen(router: self,
                                                                     parameters: parameters,
                                                                     dataPicture: image)
        else { return }
        favoriteNavigationController.pushViewController(detailViewController, animated: true)
    }
}