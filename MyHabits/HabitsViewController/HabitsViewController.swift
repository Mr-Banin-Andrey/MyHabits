//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Андрей Банин on 15.12.22..
//

import UIKit

class HabitsViewController: UIViewController {
    
    private enum Columns {
        static let numberOfItemsInLine: CGFloat = 1
    }
    
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
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collection.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: "progressID")
        collection.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "habitID")
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultID")
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return collection
    }()
    
    private var wightHeader: CGFloat = 0
    
    var realTimeVar = "0"
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.addButtonTabBarFunc()
        self.navigationBarFunc()
        
        self.setupCollection()
        
//        print("trackDate-----", HabitsStore.shared.habits[1].trackDates)
//        print("habits[1].date-----", HabitsStore.shared.habits[1].date)
//        print("dates.count-----", HabitsStore.shared.dates.count)
        print("Count.Habits, \(HabitsStore.shared.habits.count)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupCollection()
        self.navigationBarFunc()
        self.collectionView.reloadData()
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - Methods
    private func addButtonTabBarFunc() {
        navigationItem.rightBarButtonItems = [addButtonTabBar]
        navigationItem.rightBarButtonItem = addButtonTabBar
    }
    
    private func progressView() {
        let progressCell = ProgressCollectionViewCell()
        progressCell.progressView.progress = HabitsStore.shared.todayProgress
    }
    
    private func navigationBarFunc() {
        self.navigationItem.title = "Сегодня"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupCollection() {
        self.view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    
    @objc func addHabit() {
        let addHabit = HabitViewController()
        let navСontroller = UINavigationController(rootViewController: addHabit)
        navСontroller.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navСontroller, animated: true, completion: nil)
    }
}

extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        if section == 1 { return HabitsStore.shared.habits.count }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "progressID", for: indexPath) as? ProgressCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultID", for: indexPath)
                return cell
            }
            
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            cell.backgroundColor = .white
            cell.progressView.progress = HabitsStore.shared.todayProgress
            return cell
        }
        
        if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "habitID", for: indexPath) as? HabitCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultID", for: indexPath)
                return cell
            }
            
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            cell.backgroundColor = .white
            
            cell.setup(index: indexPath.row)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultId", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let insets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let interItemSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        
        let wight = collectionView.frame.width - (Columns.numberOfItemsInLine - 1) * interItemSpacing - insets.left - insets.right
        let itemWight = floor(wight / Columns.numberOfItemsInLine)
        
        wightHeader = itemWight

        if indexPath.section == 0 {
            return CGSize(width: itemWight, height: 65)
        }
        
        return CGSize(width: itemWight, height: 130)
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            let habitDetailsVC = HabitDetailsViewController()
            habitDetailsVC.numberHabitDetailsVC = indexPath.row
            habitDetailsVC.navigationItem.title = HabitsStore.shared.habits[indexPath.row].name
            navigationController?.pushViewController(habitDetailsVC, animated: true)
        }
    }
    
}
