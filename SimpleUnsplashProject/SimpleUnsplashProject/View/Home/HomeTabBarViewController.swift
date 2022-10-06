//
//  HomeTabBarViewController.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 06.10.2022.
//

import UIKit

class HomeTabBarViewController: UITabBarController {
    private enum TabBarItem: Int {
        case search
        case favourite
        
        var iconName: String {
            switch self {
            case .search:
                return "magnifyingglass"
            case .favourite:
                return "suit.heart"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTabBar()
    }
}

extension HomeTabBarViewController {
    private func setupUI() {
        tabBar.tintColor = .black
    }
    private func setupTabBar() {
        let dataSource: [TabBarItem] = [.search, .favourite]
        viewControllers = dataSource.map {
            switch $0 {
            case .search:
                let searchViewController = SearchViewController()
                return wrappedInNavigationController(with: searchViewController)
            case .favourite:
                let favouriteViewController = FavouritePicturesViewController()
                return wrappedInNavigationController(with: favouriteViewController)
            }
        }
        viewControllers?.enumerated().forEach {
            $1.tabBarItem.image = UIImage(systemName: dataSource[$0].iconName)
            $1.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: .zero, bottom: -5, right: .zero)
        }
    }
    private func wrappedInNavigationController(with: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: with)
    }
}
