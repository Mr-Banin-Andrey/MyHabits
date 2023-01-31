//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Андрей Банин on 20.1.23..
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    //MARK: - Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
        tableView.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: "headerId")
        return tableView
    }()
    
    private lazy var saveButtonTabBar: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.target = self
        button.style = .plain
        button.title = "Править"
        button.action = #selector(editHabit) 
        button.tintColor = #colorLiteral(red: 0.631372549, green: 0.0862745098, blue: 0.8, alpha: 1)
        return button
    }()
    
//    private lazy var cancelButtonTabBar: UIBarButtonItem = {
//        let button = UIBarButtonItem()
//        button.target = self
//        button.style = .plain
//        button.title = "Отменить"
//        button.action = #selector(editHabit)
//        button.tintColor = #colorLiteral(red: 0.631372549, green: 0.0862745098, blue: 0.8, alpha: 1)
//        return button
//    }()
//
    var numberHabitDetailsVC = 0
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController()
        self.setupConstraints()
    }
    
    //MARK: - Methods
    private func setupConstraints() {
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func navigationController() {
//        self.navigationItem.title = "Создать"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.631372549, green: 0.0862745098, blue: 0.8, alpha: 1)
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItems = [saveButtonTabBar]
        navigationItem.rightBarButtonItem = saveButtonTabBar
        
//        navigationItem.leftBarButtonItems = [cancelButtonTabBar]
//        navigationItem.leftBarButtonItem = cancelButtonTabBar
    }
    
    
    @objc func editHabit() {
        let habitVC = HabitViewController()
        habitVC.numberHabitVC = numberHabitDetailsVC
        habitVC.nameHabitText.text = HabitsStore.shared.habits[numberHabitDetailsVC].name
        habitVC.cycleColorButton.backgroundColor = HabitsStore.shared.habits[numberHabitDetailsVC].color
        habitVC.timeLabel.text = HabitsStore.shared.habits[numberHabitDetailsVC].dateString
        habitVC.datePicker.date = HabitsStore.shared.habits[numberHabitDetailsVC].date
//        habitVC.tabBarController?.tabBar.isHidden = true
        habitVC.alertController.message = "Вы хотите удалить привычку '\(HabitsStore.shared.habits[numberHabitDetailsVC].name)' ?"
//        habitVC.alertController.preferredStyle = .alert
        habitVC.deleteHabitButton.isHidden = false
        habitVC.saveButtonTabBar.action = #selector(habitVC.editHabit)
        habitVC.cancelButtonTabBar.action = #selector(habitVC.cancelEdit)
        habitVC.titleView = "Править"
        navigationController?.pushViewController(habitVC, animated: true)
        
    }
}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if HabitsStore.shared.habits[numberHabitDetailsVC].date.formatted(date: .long, time: .omitted) == Date().formatted(date: .long, time: .omitted) {
            return 3
        }
        
        return HabitsStore.shared.dates.count //4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
            return cell
        }
        
        //то есть добавить операцию, которая будет добавлять следующий день от даты создания привычки, но чтоб при создании привычки было 3 дня (вчера позавчера сегодня)
        let abs = HabitsStore.shared.dates.count - 1
        let abs1 = HabitsStore.shared.dates.count - 2
        let abs2 = HabitsStore.shared.dates.count - 3
        let abs3 = HabitsStore.shared.dates.count - 4
        let abb0 = [abs,abs1,abs2,abs3]
//        print(HabitsStore.shared.habits[numberHabit].date.formatted(date: .long, time: .omitted), "==", Date().formatted(date: .long, time: .omitted))
        
        let dateHabit = HabitsStore.shared.habits[numberHabitDetailsVC].date
        
        
        if HabitsStore.shared.habits[numberHabitDetailsVC].date.formatted(date: .long, time: .omitted) == Date().formatted(date: .long, time: .omitted) {
            
            let index = cell.date.tag
            
            let abb1 = [abs,abs1,abs2]
            let abb22 = abb1[indexPath.row]
            cell.date.text = HabitsStore.shared.trackDateString(forIndex: abb22)
            if HabitsStore.shared.habit(HabitsStore.shared.habits[numberHabitDetailsVC], isTrackedIn: HabitsStore.shared.dates[abb22]) {
                cell.checkMark.isHidden = false
            }
            return cell
        }
        
//        var arriveDate: [Int] = []
//        for (i, v) in HabitsStore.shared.dates.enumerated() {
//            if v.formatted(date: .long, time: .omitted) > dateHabit.formatted(date: .long, time: .omitted) {
////                print(i, "!!!!!!!",v.formatted(date: .long, time: .omitted), "???????", dateHabit.formatted(date: .long, time: .omitted))
//
//                arriveDate.append(i)
//            }
//        }
//        print(arriveDate)
//        let abb22 = abb0[indexPath.row]
//        cell.date.text = HabitsStore.shared.trackDateString(forIndex: abb22)
        
        
        
        cell.date.text = HabitsStore.shared.trackDateString(forIndex: indexPath.row)
        if HabitsStore.shared.habit(HabitsStore.shared.habits[numberHabitDetailsVC], isTrackedIn: HabitsStore.shared.dates[indexPath.row]) {
            cell.checkMark.isHidden = false
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId") as? CustomHeaderView else { return nil }
            
            return headerView
        }
        return nil
    }
}
