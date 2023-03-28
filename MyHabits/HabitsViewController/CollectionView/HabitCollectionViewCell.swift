//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Андрей Банин on 4.1.23..
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    private lazy var nameHabit: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 17)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var timeHabit: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var counter: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13)
        return label
    }()
        
    lazy var checkMarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 19
        button.layer.borderWidth = 2.5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(completedHabit), for: .touchUpInside)
        button.setImage(.init(systemName: "checkmark"), for: .normal)
        button.tintColor = .white
        return button
    }()
        
    //MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()

        self.nameHabit.text = nil
        self.nameHabit.textColor = nil
        self.timeHabit.text = nil
        self.checkMarkButton.layer.borderColor = nil
        self.checkMarkButton.backgroundColor = nil
        self.counter.text = nil
    }
    
    private func setupConstraints() {
        
        self.contentView.addSubview(self.nameHabit)
        self.contentView.addSubview(self.timeHabit)
        self.contentView.addSubview(self.counter)
        self.contentView.addSubview(self.checkMarkButton)
        
        NSLayoutConstraint.activate([
            
            self.checkMarkButton.heightAnchor.constraint(equalToConstant: 38),
            self.checkMarkButton.widthAnchor.constraint(equalToConstant: 38),
            self.checkMarkButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 47),
            self.checkMarkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -26),
            
            self.nameHabit.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            self.nameHabit.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.nameHabit.trailingAnchor.constraint(equalTo: self.checkMarkButton.leadingAnchor, constant: -40),

            self.timeHabit.topAnchor.constraint(equalTo: self.nameHabit.bottomAnchor, constant: 4),
            self.timeHabit.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),

            self.counter.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.counter.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
            
        ])

    }
    
    func setup(index: Int) {
        
        self.nameHabit.tag = index
        
        self.nameHabit.text = HabitsStore.shared.habits[index].name
        self.nameHabit.textColor = HabitsStore.shared.habits[index].color
        self.timeHabit.text = "Каждый день в \(HabitsStore.shared.habits[index].dateString)"
        self.checkMarkButton.layer.borderColor = HabitsStore.shared.habits[index].color.cgColor
        self.counter.text = "Счётчик: \(HabitsStore.shared.habits[index].trackDates.count)"
        
        if HabitsStore.shared.habits[index].isAlreadyTakenToday {
            checkMarkButton.backgroundColor = UIColor(cgColor: checkMarkButton.layer.borderColor ?? UIColor.white.cgColor)
        } else {
            checkMarkButton.backgroundColor = .white
        }
    }
    
    @objc func completedHabit() {
        
        let index = nameHabit.tag

        if HabitsStore.shared.habits[index].isAlreadyTakenToday {
            print("comletedHabit")
        } else {
            checkMarkButton.backgroundColor = UIColor(cgColor: checkMarkButton.layer.borderColor ?? UIColor.white.cgColor)
            HabitsStore.shared.track(HabitsStore.shared.habits[index])
            self.counter.text = "Счётчик: \(HabitsStore.shared.habits[index].trackDates.count)"
        
        }
    }
}
