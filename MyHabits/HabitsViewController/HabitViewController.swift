//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Андрей Банин on 20.12.22..
//

import UIKit

class HabitViewController: UIViewController {
    
    //MARK: - Properties
    lazy var saveButtonTabBar: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.target = self
        button.style = .plain
        button.title = "Сохранить"
        button.action = #selector(saveHabit)
        button.tintColor = #colorLiteral(red: 0.631372549, green: 0.0862745098, blue: 0.8, alpha: 1)
        return button
    }()
    
    lazy var cancelButtonTabBar: UIBarButtonItem = {
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
    
    lazy var nameHabitText: UITextField = {
        let nameHabitText = UITextField()
        nameHabitText.placeholder = "Бегать по утрам, спать 8 часов и т.п."
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
    
    lazy var cycleColorButton: UIButton = {
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
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.631372549, green: 0.0862745098, blue: 0.8, alpha: 1)
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = realTimeVar
        return label
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .time
        datePicker.addTarget(self, action: #selector(chooseTime), for: .valueChanged)
        return datePicker
    }()
    
    var variableText: String = ""
    var variableColor: UIColor = .systemOrange
    var variableTime = Date()
    private var realTimeVar = ""
    
    var numberHabitVC = 0
    
    lazy var deleteHabitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(UIColor.systemRed, for: .normal)
        button.addTarget(self, action: #selector(addTargetShowAlertDeleteHabit), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    var alertController = UIAlertController(title: "Удалить привычку", message: "что-то", preferredStyle: .alert)
    
    let alertControllerCheckEmptyText = UIAlertController(title: "Ошибка", message: "название должно быть заполнено", preferredStyle: .alert)
    
    var titleView = "Создать"
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.realTime()
        self.view.backgroundColor = .systemBackground
        self.navigationController()
        self.setupConstraints()
        self.setupAlertControllerDeleteHabit()
        self.setupAlertControllerCheckEmptyText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    //MARK: - Methods
    
    private func navigationController() {
        self.navigationItem.title = titleView
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
        self.view.addSubview(self.deleteHabitButton)
        
        NSLayoutConstraint.activate([
            self.nameHabitLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 24),
            self.nameHabitLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            
            self.nameHabitText.topAnchor.constraint(equalTo: self.nameHabitLabel.bottomAnchor, constant: 8),
            self.nameHabitText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.nameHabitText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            
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
            self.datePicker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            self.deleteHabitButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -24),
            self.deleteHabitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    private func realTime() {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "HH:MM AM/PM"
        df.timeStyle = .short
        realTimeVar = df.string(from: date)
    }
    
    func setupAlertControllerDeleteHabit() {
        alertController.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { _ in
            self.deleteHabit()
        }))
        alertController.addAction(UIAlertAction(title: "Отменить", style: .cancel))
    }
    
    func setupAlertControllerCheckEmptyText() {
        alertControllerCheckEmptyText.addAction(UIAlertAction(title: "Попробовать ещё раз", style: .cancel))
    }
    
    @objc func saveHabit(){
        
        if self.nameHabitText.text == "" {
            addTargetShowAlertEmptyTextField()
        } else {
            if self.nameHabitText.text != nil {
                variableText = self.nameHabitText.text!
            }
            
            let newHabit = Habit(name: variableText, date: variableTime, color: variableColor)
            let store = HabitsStore.shared
            store.habits.append(newHabit)

            self.dismiss(animated: true)
        }
        
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
        
        variableTime = self.datePicker.date
    }
    
    @objc func editHabit() {
        
        if self.nameHabitText.text == "" {
            addTargetShowAlertEmptyTextField()
        } else {
            
            if self.nameHabitText.text != nil {
                variableText = self.nameHabitText.text!
            }
            
            HabitsStore.shared.habits[numberHabitVC].name = variableText
            HabitsStore.shared.habits[numberHabitVC].date = variableTime
            HabitsStore.shared.habits[numberHabitVC].color = variableColor
            
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc func cancelEdit() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func deleteHabit() {
        HabitsStore.shared.habits.remove(at: numberHabitVC)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func addTargetShowAlertDeleteHabit () {
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func addTargetShowAlertEmptyTextField () {
        self.present(alertControllerCheckEmptyText, animated: true, completion: nil)
    }
}


extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    internal func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        cycleColorButton.backgroundColor = color
        variableColor = color
    }
    
}
