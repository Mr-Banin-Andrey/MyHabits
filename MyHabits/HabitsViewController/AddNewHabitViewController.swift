//
//  AddNewHabitViewController.swift
//  MyHabits
//
//  Created by Андрей Банин on 20.12.22..
//

import UIKit

class AddNewHabitViewController: UIViewController {
    
    //MARK: - Properties
    private lazy var saveButtonTabBar: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.target = self
        button.style = .plain
        button.title = "Сохранить"
        button.action = #selector(saveHabit)
        button.tintColor = #colorLiteral(red: 0.631372549, green: 0.0862745098, blue: 0.8, alpha: 1)
        return button
    }()
    
    private lazy var cancelButtonTabBar: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.target = self
        button.style = .plain
        button.title = "Отменить"
        button.action = #selector(cancelDo)
        button.tintColor = #colorLiteral(red: 0.631372549, green: 0.0862745098, blue: 0.8, alpha: 1)
        return button
    }()
    
    private lazy var nameHabitLabel: UILabel = {
        let nameHabit = UILabel()
        nameHabit.text = "НАЗВАНИЕ"
        nameHabit.font = .boldSystemFont(ofSize: 13)
        nameHabit.textColor = .black
        nameHabit.translatesAutoresizingMaskIntoConstraints = false
        return nameHabit
    }()
    
    private lazy var nameHabitText: UITextField = {
        let nameHabitText = UITextField()
        nameHabitText.placeholder = "Бегать по утрам, спать 8 часов и т.п."
//        nameHabitText.te
        nameHabitText.translatesAutoresizingMaskIntoConstraints = false
        nameHabitText.font = .systemFont(ofSize: 17)
        nameHabitText.textColor = .black
        return nameHabitText
    }()
    
    private lazy var colorNameLabel: UILabel = {
        let colorNameLabel = UILabel()
        colorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        colorNameLabel.text = "ЦВЕТ"
        colorNameLabel.font = .boldSystemFont(ofSize: 13)
        colorNameLabel.textColor = .black
        return colorNameLabel
    }()
    
    private lazy var cycleColorButton: UIButton = {
        let cycleColorButton = UIButton()
        cycleColorButton.layer.cornerRadius = 15
        cycleColorButton.translatesAutoresizingMaskIntoConstraints = false
        cycleColorButton.backgroundColor = .systemOrange
        cycleColorButton.addTarget(self, action: #selector(colorChoose), for: .touchUpInside)
        return cycleColorButton
    }()
    
    private lazy var timeNameLabel: UILabel = {
        let timeNameLabel = UILabel()
        timeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        timeNameLabel.text = "ВРЕМЯ"
        timeNameLabel.font = .boldSystemFont(ofSize: 13)
        timeNameLabel.textColor = .black
        return timeNameLabel
    }()
    
    private lazy var exactTimeStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Каждый день в"
        label.textColor = .black
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "10:09 AM"
        label.textColor = #colorLiteral(red: 0.631372549, green: 0.0862745098, blue: 0.8, alpha: 1)
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        datePicker.addTarget(self, action: #selector(chooseTime), for: .valueChanged)
        return datePicker
    }()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBackground
        self.navigationController()
        self.setupConstraints()
    }
    
    //MARK: - Methods
    
    private func navigationController() {
        self.navigationItem.title = "Создать"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItems = [saveButtonTabBar]
        navigationItem.rightBarButtonItem = saveButtonTabBar
        
        navigationItem.leftBarButtonItems = [cancelButtonTabBar]
        navigationItem.leftBarButtonItem = cancelButtonTabBar
    }
    
    private func setupConstraints() {
        
        self.view.addSubview(self.nameHabitLabel)
        self.view.addSubview(self.nameHabitText)
        self.view.addSubview(self.colorNameLabel)
        self.view.addSubview(self.cycleColorButton)
        self.view.addSubview(self.timeNameLabel)
        self.view.addSubview(self.exactTimeStack)
        self.exactTimeStack.addArrangedSubview(self.textLabel)
        self.exactTimeStack.addArrangedSubview(self.timeLabel)
        self.view.addSubview(self.datePicker)
        
        NSLayoutConstraint.activate([
            self.nameHabitLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 24),
            self.nameHabitLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            
            self.nameHabitText.topAnchor.constraint(equalTo: self.nameHabitLabel.bottomAnchor, constant: 8),
            self.nameHabitText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            
            self.colorNameLabel.topAnchor.constraint(equalTo: self.nameHabitText.bottomAnchor, constant: 16),
            self.colorNameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            
            self.cycleColorButton.widthAnchor.constraint(equalToConstant: 30),
            self.cycleColorButton.heightAnchor.constraint(equalToConstant: 30),
            self.cycleColorButton.topAnchor.constraint(equalTo: self.colorNameLabel.bottomAnchor, constant: 8),
            self.cycleColorButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            
            self.timeNameLabel.topAnchor.constraint(equalTo: self.cycleColorButton.bottomAnchor, constant: 16),
            self.timeNameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            
            self.exactTimeStack.topAnchor.constraint(equalTo: self.timeNameLabel.bottomAnchor, constant: 8),
            self.exactTimeStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            
            self.datePicker.topAnchor.constraint(equalTo: self.timeNameLabel.bottomAnchor, constant: 16),
            self.datePicker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    @objc func saveHabit(){
//        print(self.nameHabitText.text)
//        print(self.cycleColorButton.)
//        print(self.timeLabel.text)
    }
    
    @objc func cancelDo() {
        self.dismiss(animated: true)
    }
    
    @objc func colorChoose() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        present(colorPicker, animated: true)
    }
    
    @objc func chooseTime() {
        let time = DateFormatter()
        time.dateFormat = "HH:MM AM/PM"
        time.timeStyle = .short
        self.timeLabel.text = time.string(from: self.datePicker.date)
    }
    
//    let newHabit = Habit(name: "Выпить стакан воды перед завтраком", date: Date(), color: .systemRed)
//    let store = HabitsStore.shared
//    store.habits.append(newHabit)
}


extension AddNewHabitViewController: UIColorPickerViewControllerDelegate {
    
    internal func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        cycleColorButton.backgroundColor = color
        print(cycleColorButton.backgroundColor = color)
    }
    
}
