//
//  MainTabBarController.swift
//  MoviesApp
//
//  Created by SabinaKarimli on 30.12.25.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBar()
        setupAppearence()
    }
    
    private func setupBar() {
        let homeVC = MoviesViewController()
        let searchVC = SearchViewController()
        let watchListVC = WatchListViewController()
        let homeNavBar = UINavigationController(rootViewController: homeVC)
        let searchNavBar = UINavigationController(rootViewController: searchVC)
        let watchListNavBar = UINavigationController(rootViewController: watchListVC)
        homeNavBar.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "home"),
            tag: 0
        )
        
        searchNavBar.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 1
        )
        
        watchListNavBar.tabBarItem = UITabBarItem(
            title: "Watch List",
            image: UIImage(systemName: "bookmark"),
            tag: 2
        )
        
        
        viewControllers = [
            homeNavBar,
            searchNavBar,
            watchListNavBar
        ]
    }

    private func setupAppearence() {
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .systemGray
        tabBar.backgroundColor = .systemBackground
    }
    

}
