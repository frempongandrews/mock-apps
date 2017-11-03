//
//  CustomTabBarController.swift
//  02-facebookNewsFeed-part-4
//
//  Created by Andrews Frempong on 23/10/2017.
//  Copyright © 2017 Andrews Frempong. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor = UIColor.init(red: 229/255, green: 231/255, blue: 235/255, alpha: 1).cgColor
        //removes the 1px tall top native top border on the tab bar
        tabBar.clipsToBounds = true
        //adds 0.5 px tall border to replace native 1px border
        tabBar.layer.addSublayer(topBorder)
        
        //color of items
        //tabBar.tintColor = UIColor.init(red: 70/255, green: 146/255, blue: 250/255, alpha: 1)
        
        
        //feed screen
        let layout = UICollectionViewFlowLayout()
        let feedViewController = FeedViewController(collectionViewLayout: layout)
        let feedsNavigationController = UINavigationController(rootViewController: feedViewController)
        //The title of the item in the tabBar
        feedsNavigationController.title = "Facebook Feed"
        feedsNavigationController.tabBarItem.image = #imageLiteral(resourceName: "news_feed_icon")
        
        
        
        //friend requests screen
        let friendRequestsVC = FriendsRequestsVC()
        let friendsNavigationController = UINavigationController(rootViewController: friendRequestsVC)
        
        //friendsNavigationController.title = "Requests" //or as below
        friendsNavigationController.tabBarItem.title = "Requests"
        friendsNavigationController.tabBarItem.image = #imageLiteral(resourceName: "requests_icon")
        
        
        //messenger screen
        
        let messengerVC = MessengerVC()
        let messengerNavigationController = UINavigationController(rootViewController: messengerVC)
        messengerNavigationController.title = "Messenger"
        messengerNavigationController.tabBarItem.image = #imageLiteral(resourceName: "messenger_icon")
      
        
        //notifications screen
        
        let notificationsVC = NotificationsVC()
        let notificationsNavigationController = UINavigationController(rootViewController: notificationsVC)
        notificationsVC.title = "Notifications"
        notificationsNavigationController.tabBarItem.image = #imageLiteral(resourceName: "notifications-icon")
        
        
        //more screen
        let moreVC = MoreVC()
        let moreNavigationController = UINavigationController(rootViewController: moreVC)
        moreNavigationController.title = "More"
        moreNavigationController.tabBarItem.image = #imageLiteral(resourceName: "more_icon")
        
        
        //what the tabBarcontroller shows
        viewControllers = [feedsNavigationController, friendsNavigationController, messengerNavigationController, notificationsNavigationController, moreNavigationController]
    }
    
}
