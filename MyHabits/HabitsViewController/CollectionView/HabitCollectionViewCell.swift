//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Андрей Банин on 4.1.23..
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    lazy var nameHabit: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 17)
        label.numberOfLines = 2
        label.text = "one"
        label.textColor = .systemRed
        return label
    }()
    
    lazy var timeHabit: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 12)
        label.text = "two"
        return label
    }()
    
    lazy var counter: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13)
        label.text = "three"
        return label
    }()
    
    lazy var checkMarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 2.5
        button.layer.borderColor = UIColor.systemRed.cgColor
        button.layer.cornerRadius = 18
        button.addTarget(self, action: #selector(completedHabit), for: .touchUpInside)
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
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//
//        self.nameHabit.text = nil
//        self.descriptionLabel.text = nil
//        self.imagePhotoView.image = nil
//        self.viewsAmountLabel.text = nil
//        self.likesAmountLabel.text = nil
//    }
    
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
            self.nameHabit.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -40),

            self.timeHabit.topAnchor.constraint(equalTo: self.nameHabit.bottomAnchor, constant: 4),
            self.timeHabit.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),

            self.counter.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.counter.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
            
        ])

    }
    
    @objc func completedHabit() {

        print("hello_cell")
        checkMarkButton.setImage(.init(systemName: "checkmark"), for: .normal)
        checkMarkButton.tintColor = .white
        checkMarkButton.backgroundColor = .systemRed
    }
    
}
