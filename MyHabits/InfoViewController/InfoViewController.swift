//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Андрей Банин on 15.12.22..
//

import UIKit

class InfoViewController: UIViewController {
    
    private let arriveTextBlockInfo: [InfoCustomTableViewCell.TextBlock] = [
        InfoCustomTableViewCell.TextBlock(text: "Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:"),
        InfoCustomTableViewCell.TextBlock(text:"1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага."),
        InfoCustomTableViewCell.TextBlock(text: "2. Выдержать 2 дня в прежнем состоянии самоконтроля."),
        InfoCustomTableViewCell.TextBlock(text: "3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться."),
        InfoCustomTableViewCell.TextBlock(text: "4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств."),
        InfoCustomTableViewCell.TextBlock(text: "5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой."),
        InfoCustomTableViewCell.TextBlock(text: "6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся."),
        InfoCustomTableViewCell.TextBlock(text: "Источник: psychbook.ru")
    ]

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(InfoCustomTableViewCell.self, forCellReuseIdentifier: "customId")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultId")
        tableView.register(InfoCustomHeaderView.self, forHeaderFooterViewReuseIdentifier: "headerId")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        
        navigationBarFunc()
        setupConstraints()
    }
    
    
    private func navigationBarFunc() {
        self.navigationItem.title = "Информация"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupConstraints() {
        
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension InfoViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arriveTextBlockInfo.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customId", for: indexPath) as? InfoCustomTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "defaultId", for: indexPath)
            return cell
        }
        
        let block = self.arriveTextBlockInfo[indexPath.row]
        
        cell.setup(with: block)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId") as? InfoCustomHeaderView else { return nil }

            let viewModel = InfoCustomHeaderView.ViewModel(text: "Привычка за 21 день")
            headerView.setup(with: viewModel)
            return headerView
        }
        return nil
    }
}
