//
//  AddNewHabitViewController.swift
//  MyHabits
//
//  Created by Андрей Банин on 20.12.22..
//

import UIKit

class AddNewHabitViewController: UIViewController {
    
    private lazy var saveButtonTabBar: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.target = self
        button.style = .plain
        button.title = "Сохранить" 
        button.action = #selector(showAddTapped)
        button.tintColor = #colorLiteral(red: 0.631372549, green: 0.0862745098, blue: 0.8, alpha: 1)
        return button
    }()
    
    private lazy var cancelButtonTabBar: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.target = self
        button.style = .plain
        button.title = "Отменить"
        button.action = #selector(showAddTapped)
        button.tintColor = #colorLiteral(red: 0.631372549, green: 0.0862745098, blue: 0.8, alpha: 1)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
        
        navigationBarFunc()
        saveButtonTabBarFunc()
        cancelButtonTabBarFunc()
    }
    
    private func cancelButtonTabBarFunc() {
        navigationItem.leftBarButtonItems = [cancelButtonTabBar]
        navigationItem.leftBarButtonItem = cancelButtonTabBar
    }
    
    private func saveButtonTabBarFunc() {
        navigationItem.rightBarButtonItems = [saveButtonTabBar]
        navigationItem.rightBarButtonItem = saveButtonTabBar
    }
    
    private func navigationBarFunc() {
        self.navigationItem.title = "Создать"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.largeTitleDisplayMode = .never
    }
    
    @objc func showAddTapped() {
    }
}
