//
//  TabBarVC.swift
//  Pokedex Final
//
//  Created by Anthony Duran on 5/23/24.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.delegate = self
    }
    
    // Trying to reload data when Favorites tab is tapped
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let favoritesCollectionVC = viewController as? FavoritesCollectionVC {
            favoritesCollectionVC.collectionView.reloadData()
        }
    }
    
}
