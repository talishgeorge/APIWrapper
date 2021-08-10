//
//  MainTabBarController.swift
//  APIWarpper
//
//  Created by Talish George on 18/01/21.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    // Mark: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureViewControllers()
    }
    
    func configureViewControllers() {

        let news = templateNavigationController(unSelectedImage: #imageLiteral(resourceName: "home_selected"), selectedImage: #imageLiteral(resourceName: "home_unselected"), rootViewController: NewsController())
        
        let feed = templateNavigationController(unSelectedImage: #imageLiteral(resourceName: "like_selected"), selectedImage: #imageLiteral(resourceName: "like_unselected"), rootViewController: FeedController())
        let search = templateNavigationController(unSelectedImage: #imageLiteral(resourceName: "search_selected"), selectedImage: #imageLiteral(resourceName: "search_unselected"), rootViewController: SearchController())
        
        viewControllers = [news, feed, search]
    }

    func templateNavigationController(unSelectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = unSelectedImage
        navController.tabBarItem.selectedImage = selectedImage
        navController.navigationBar.tintColor = .black
        return navController
    }
    
}
