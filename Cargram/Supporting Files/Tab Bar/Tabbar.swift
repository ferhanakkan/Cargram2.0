//
//  Tabbar.swift
//  Cargram
//
//  Created by Ferhan Akkan on 11.05.2020.
//  Copyright © 2020 Ferhan Akkan. All rights reserved.
//

import UIKit
import Firebase

class Tabbar {
    class func createTabBarWithNavigationBar() -> UITabBarController {
         
        let tabController = UITabBarController()
        
        let explore = AuthViewController()
        let meeting = TestScreenViewController()
        let posts = TestScreenViewController()
        let todo = TestScreenViewController()
        let forum = TestScreenViewController()
        
        //        if let imageUrl = Auth.auth().currentUser?.photoURL {
        //            let data = try? Data(contentsOf: imageUrl)
        //            UserDefaults.standard.setValue(data, forKey: "profileImage")
        //        }
        
        
        //        if Auth.auth().currentUser != nil {
        
        explore.title = "Explore"
        meeting.title = "Meetings"
        posts.title = "Posts"
        todo.title = "To Do"
        forum.title = "Forum"
        
        tabController.viewControllers = [UINavigationController(rootViewController: explore),UINavigationController(rootViewController: meeting),UINavigationController(rootViewController: posts),UINavigationController(rootViewController: todo),UINavigationController(rootViewController: forum)]
        
        tabController.tabBar.backgroundColor = .backgroundGreen
        tabController.tabBar.barTintColor = .backgroundGreen
        tabController.tabBar.tintColor = .darkGray
        
        tabController.tabBar.items?[0].image = UIImage(named: "explore")
        tabController.tabBar.items![0].selectedImage = UIImage(named: "explore")
        tabController.tabBar.items?[1].image = UIImage(named: "meeting")
        tabController.tabBar.items![1].selectedImage = UIImage(named: "meeting")
        tabController.tabBar.items?[2].image = UIImage(named: "posts")
        tabController.tabBar.items![2].selectedImage = UIImage(named: "posts")
        tabController.tabBar.items?[3].image = UIImage(named: "todo")
        tabController.tabBar.items![3].selectedImage = UIImage(named: "todo")
        tabController.tabBar.items?[4].image = UIImage(named: "forum")
        tabController.tabBar.items![4].selectedImage = UIImage(named: "forum")
        
        return tabController
    }
}
