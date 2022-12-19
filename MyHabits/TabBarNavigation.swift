//
//  TabBarNavigation.swift
//  MyHabits
//
//  Created by Андрей Банин on 15.12.22..
//

import UIKit

class TabBarNavigation: UITabBarController {
    
    var habitsViewController: UIViewController!
    var infoViewController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        
        habitsViewController = UINavigationController.init(rootViewController: HabitsViewController())
        infoViewController = UINavigationController.init(rootViewController: InfoViewController())
        
        self.viewControllers = [habitsViewController, infoViewController]
        
        let habits = UITabBarItem(title: "Привычки", image: UIImage(named: "tab_icon"), tag: 0)
        let info = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle.fill"), tag: 1)
        
        habitsViewController.tabBarItem = habits
        infoViewController.tabBarItem = info
        
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.631372549, green: 0.0862745098, blue: 0.8, alpha: 1)
        UITabBar.appearance().backgroundColor = .white
    }
}

