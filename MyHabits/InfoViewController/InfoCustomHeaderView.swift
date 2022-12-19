//
//  InfoCustomHeaderView.swift
//  MyHabits
//
//  Created by Андрей Банин on 19.12.22..
//

import UIKit

class InfoCustomHeaderView: UITableViewHeaderFooterView {
    
    struct ViewModel {
        let text:String
    }
    
    private lazy var headerLabel: UILabel = {
        let header = UILabel()
        header.textColor = .black
        header.font = UIFont.preferredFont(forTextStyle: .title3)
        header.font = .systemFont(ofSize: 20, weight: .bold)
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with viewModel: ViewModel) {
        self.headerLabel.text = viewModel.text
    }
    
    private func setupConstraints() {
        
        self.addSubview(self.headerLabel)
        
        NSLayoutConstraint.activate([
            self.headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 22),
            self.headerLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.headerLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            self.headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            self.headerLabel.heightAnchor.constraint(equalTo: self.headerLabel.heightAnchor)
        ])
        
    }
}
