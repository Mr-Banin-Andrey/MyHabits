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
        label.text = "one"
        return label
    }()
    
    private lazy var timeHabit: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 12)
        label.text = "two"
        return label
    }()
    
    private lazy var counter: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13)
        label.text = "three"
        return label
    }()
    
    private lazy var cycle: UIView = {
        let label = UIView()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderWidth = 2.5
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.cornerRadius = 18
        return label
    }()
    
    private lazy var markButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.tintColor = .black
        button.setTitle("AA", for: .normal)
//        button.setImage("checkmark", for: <#T##UIControl.State#>)
//        button.setImage(.checkmark, for: .normal)
//        button.imageView =
        return button
    }()
    
    //MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupConstraints()
        self.addTarget()
        self.setupGestures()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func addTarget() {
        markButton.addTarget(self, action: #selector(completedHabit), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        
        self.addSubview(self.nameHabit)
        self.addSubview(self.timeHabit)
        self.addSubview(self.counter)
        self.addSubview(self.cycle)
        self.addSubview(self.markButton)
        
        NSLayoutConstraint.activate([
            
            self.cycle.heightAnchor.constraint(equalToConstant: 38),
            self.cycle.widthAnchor.constraint(equalToConstant: 38),
            self.cycle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 47),
            self.cycle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -26),
            
            self.nameHabit.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            self.nameHabit.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.nameHabit.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -40),

            self.timeHabit.topAnchor.constraint(equalTo: self.nameHabit.bottomAnchor, constant: 4),
            self.timeHabit.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),

            self.counter.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.counter.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            
            self.markButton.heightAnchor.constraint(equalToConstant: 32),
            self.markButton.widthAnchor.constraint(equalToConstant: 32),
            self.markButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 50),
            self.markButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
//            self.markButton.centerYAnchor.constraint(equalTo: self.cycle.centerYAnchor)
        ])

    }
    
    private func setupGestures() {
        let tapGestures = UITapGestureRecognizer(target: self, action: #selector(self.completedHabit))
        self.markButton.addGestureRecognizer(tapGestures)
    }
    
    @objc func completedHabit() {
        
//        let redTapImage = UIImage(systemName: "checkmark")
//        markButton.setImage(redTapImage, for: .normal)
        print("hello")
//        markButton.im = UIImage(systemName: "checkmark.circle")
        
    }
    
    
}
