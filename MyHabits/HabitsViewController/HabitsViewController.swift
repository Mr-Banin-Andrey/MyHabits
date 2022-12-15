//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Андрей Банин on 15.12.22..
//

import UIKit

class HabitsViewController: UIViewController {
    
    private lazy var addButtonTabBar: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.target = self
        button.style = .plain
        button.image = UIImage(systemName: "plus")
        button.action = #selector(showAddTapped)
        button.tintColor = #colorLiteral(red: 0.631372549, green: 0.0862745098, blue: 0.8, alpha: 1)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        addButtonTabBarFunc()

    }
    
    private func addButtonTabBarFunc() {
        navigationItem.rightBarButtonItems = [addButtonTabBar]
        navigationItem.rightBarButtonItem = addButtonTabBar
    }
    
    
    @objc func showAddTapped() {
        
    }
}

