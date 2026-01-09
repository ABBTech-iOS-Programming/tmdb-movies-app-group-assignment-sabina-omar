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
        setupTabBarSeparator()
    }
    
    private func setupBar() {
        let homeVC = MoviesBuilder.build()
        let searchVC = SearchViewController()
        let watchListVC = WatchListViewController()
        let homeNavBar = UINavigationController(rootViewController: homeVC)
        let searchNavBar = UINavigationController(rootViewController: searchVC)
        let watchListNavBar = UINavigationController(rootViewController: watchListVC)
        homeNavBar.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
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

    private func setupTabBarSeparator() {
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()

        let line = UIView(frame: CGRect(x: 0, y: -10, width: tabBar.bounds.width, height: 0.5))
        line.backgroundColor = UIColor(named: "selectedTabBar")
        line.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        tabBar.addSubview(line)

        tabBar.tintColor = UIColor(named: "selectedTabBar")
        tabBar.unselectedItemTintColor = UIColor(named: "unselectedTabBar")
    }



    

}
