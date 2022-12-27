//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Андрей Банин on 15.12.22..
//

import UIKit

class HabitsViewController: UIViewController {
    
    //MARK: - Properties
    private lazy var addButtonTabBar: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.target = self
        button.style = .plain
        button.image = UIImage(systemName: "plus")
        button.action = #selector(addHabit)
        button.tintColor = #colorLiteral(red: 0.631372549, green: 0.0862745098, blue: 0.8, alpha: 1)
        return button
    }()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .lightGray
        
        self.addButtonTabBarFunc()
        self.navigationBarFunc()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - Methods
    private func addButtonTabBarFunc() {
        navigationItem.rightBarButtonItems = [addButtonTabBar]
        navigationItem.rightBarButtonItem = addButtonTabBar
    }
    
    private func navigationBarFunc() {
        self.navigationItem.title = "Сегодня"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    
    }
    
    @objc func addHabit() {
        let addHabit = AddNewHabitViewController()
        
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        self.navigationController!.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(addHabit, animated: false)
    }
}


