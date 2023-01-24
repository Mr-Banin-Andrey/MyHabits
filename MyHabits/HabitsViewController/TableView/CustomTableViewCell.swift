//
//  CustomTableViewCell.swift
//  MyHabits
//
//  Created by Андрей Банин on 24.1.23..
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    private lazy var date: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var checkMark: UIImageView = {
        let checkMark = UIImageView()
        checkMark.translatesAutoresizingMaskIntoConstraints = false
        checkMark.image = UIImage(systemName: "checkmark")
        checkMark.tintColor = #colorLiteral(red: 0.631372549, green: 0.0862745098, blue: 0.8, alpha: 1)
//        checkMark.isHidden = true
        return checkMark
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        self.contentView.addSubview(self.date)
        self.contentView.addSubview(self.checkMark)
        
        NSLayoutConstraint.activate([
            self.date.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.date.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            self.date.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            self.checkMark.widthAnchor.constraint(equalToConstant: 26),
            self.checkMark.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.checkMark.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            self.checkMark.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func setup(index: Int) {
        
        
        self.date.text = HabitsStore.shared.dates[index].formatted(date: .long, time: .omitted)
        print(HabitsStore.shared.dates)
//        if HabitsStore.shared.habit(HabitsStore.shared.habits[index], isTrackedIn: HabitsStore.shared.dates[index]) {
//            self.date.text = HabitsStore.shared.dates[index].ISO8601Format()
//            checkMark.isHidden = false
//        } else {
//            checkMark.isHidden = true
//        }
    }
}
