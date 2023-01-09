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
        layout.headerReferenceSize = .init(width: wightHeader, height: 60)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collection.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "habitID")
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "defaultID")
        collection.register(ProgressCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID")
        collection.delegate = self
        collection.dataSource = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .systemBackground
        return collection
    }()
    
    lazy var wightHeader: CGFloat = 0
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.addButtonTabBarFunc()
        self.navigationBarFunc()
        
        self.setupCollection()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupCollection()
        print(HabitsStore.shared.habits.count)

//        tabBarController?.tabBar.isHidden = false
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
        let addHabit = AddNewHabitViewController()
        let navСontroller = UINavigationController(rootViewController: addHabit)
        navСontroller.modalPresentationStyle = .fullScreen
        self.navigationController?.present(navСontroller, animated: true, completion: nil)
    }
}

extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        HabitsStore.shared.habits.count 
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "habitID", for: indexPath) as? HabitCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultID", for: indexPath)
            return cell
        }
        
        let habits = HabitsStore.shared.habits
        
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        cell.backgroundColor = .systemFill
        
        cell.nameHabit.text = habits[indexPath.row].name
        cell.nameHabit.textColor = habits[indexPath.row].color
        cell.timeHabit.text = habits[indexPath.row].dateString
        cell.checkMarkButton.layer.borderColor = habits[indexPath.row].color.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let insets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let interItemSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        
        let wight = collectionView.frame.width - (Columns.numberOfItemsInLine - 1) * interItemSpacing - insets.left - insets.right
        let itemWight = floor(wight / Columns.numberOfItemsInLine)
        
        wightHeader = itemWight

        return CGSize(width: itemWight, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as? ProgressCollectionViewCell else { return UICollectionReusableView() }
            
            view.layer.cornerRadius = 8
            view.clipsToBounds = true
            view.backgroundColor = .systemFill
            return view
            
        default:
            return UICollectionReusableView()
        }
    }
    
}
