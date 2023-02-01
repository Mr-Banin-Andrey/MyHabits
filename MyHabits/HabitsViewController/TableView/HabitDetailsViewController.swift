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
    
    var numberHabitDetailsVC = 0
    
    var arriveDates: [Int] = []
    var indexDate = 100
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.indexTable()
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
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.631372549, green: 0.0862745098, blue: 0.8, alpha: 1)
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItems = [saveButtonTabBar]
        navigationItem.rightBarButtonItem = saveButtonTabBar
    }
    
    private func indexTable() {
        for (i, v) in HabitsStore.shared.dates.enumerated() {
            
            if HabitsStore.shared.habits[numberHabitDetailsVC].date.formatted(date: .long, time: .omitted) == v.formatted(date: .long, time: .omitted) {
                indexDate = i
            }
            if i >= indexDate {
                arriveDates.append(i)
            }
        }
    }
    
    @objc func editHabit() {
        let habitVC = HabitViewController()
        habitVC.numberHabitVC = numberHabitDetailsVC
        habitVC.nameHabitText.text = HabitsStore.shared.habits[numberHabitDetailsVC].name
        habitVC.variableText = HabitsStore.shared.habits[numberHabitDetailsVC].name
        habitVC.cycleColorButton.backgroundColor = HabitsStore.shared.habits[numberHabitDetailsVC].color
        habitVC.variableColor = HabitsStore.shared.habits[numberHabitDetailsVC].color
        habitVC.timeLabel.text = HabitsStore.shared.habits[numberHabitDetailsVC].dateString
        habitVC.variableTime = HabitsStore.shared.habits[numberHabitDetailsVC].date
        habitVC.datePicker.date = HabitsStore.shared.habits[numberHabitDetailsVC].date
        habitVC.alertController.message = "Вы хотите удалить привычку '\(HabitsStore.shared.habits[numberHabitDetailsVC].name)' ?"
        habitVC.deleteHabitButton.isHidden = false
        habitVC.saveButtonTabBar.action = #selector(habitVC.editHabit)
        habitVC.cancelButtonTabBar.action = #selector(habitVC.cancelEdit)
        habitVC.titleView = "Править"
        navigationController?.pushViewController(habitVC, animated: true)
        
    }
}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
        return arriveDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
            return cell
        }
        
        let index = arriveDates[indexPath.row]
        
        cell.date.text = HabitsStore.shared.trackDateString(forIndex: index)
        if HabitsStore.shared.habit(HabitsStore.shared.habits[numberHabitDetailsVC], isTrackedIn: HabitsStore.shared.dates[index]) {
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
