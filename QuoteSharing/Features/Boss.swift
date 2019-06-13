//
//  Boss.swift
//  QuoteSharing
//
//  Created by Ky Nguyen on 6/13/19.
//  Copyright © 2019 Ky Nguyen. All rights reserved.
//

import UIKit

class Boss: UITabBarController {
    let exploreController = ExploreController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        exploreController.navigationItem.title = "Explore"
        let exploreNav = wrapToNavigation(controller: exploreController, tabBarTitle: "Explore", iconName: "explore")
        

        let searchController = UIViewController()
        searchController.navigationItem.title = "Search"
        let searchNav = wrapToNavigation(controller: searchController, tabBarTitle: "Search", iconName: "search")
        
        
        viewControllers = [
            exploreNav,
            searchNav,
        ]
    }
    
    func wrapToNavigation(controller: UIViewController,
                          tabBarTitle: String, iconName: String) -> UINavigationController {
        let nav = UINavigationController(rootViewController: controller)
        nav.tabBarItem.title = tabBarTitle
        nav.tabBarItem.image = UIImage(named: iconName)
        nav.navigationBar.prefersLargeTitles = true
        return nav
    }
}
