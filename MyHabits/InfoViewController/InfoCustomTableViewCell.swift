//
//  InfoCustomTableViewCell.swift
//  MyHabits
//
//  Created by Андрей Банин on 16.12.22..
//

import UIKit

class InfoCustomTableViewCell: UITableViewCell {
    
    struct TextBlock {
        let text: String
    }
    
    private lazy var textBlockLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.textBlockLabel.text = nil
    }
    
    func setup(with textBlock: TextBlock){        
        self.textBlockLabel.text = textBlock.text
    }
    
    
    private func setupConstraints() {
        
        self.contentView.addSubview(self.textBlockLabel)
        
        NSLayoutConstraint.activate([
            self.textBlockLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.textBlockLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.textBlockLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.textBlockLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)
        ])
    }
}
