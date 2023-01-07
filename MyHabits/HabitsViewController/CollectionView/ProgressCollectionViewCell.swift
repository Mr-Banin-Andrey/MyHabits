//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Андрей Банин on 4.1.23..
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    private lazy var nameProgressiveView: UILabel = {
        let label = UILabel()
        label.text = "Всё получится!"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.progressTintColor = #colorLiteral(red: 0.631372549, green: 0.0862745098, blue: 0.8, alpha: 1)
//        progress.sizeToFit()
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
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
    private func setupConstraints() {
        
        self.addSubview(self.nameProgressiveView)
        self.addSubview(self.progressView)
        
        NSLayoutConstraint.activate([
            self.nameProgressiveView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            self.nameProgressiveView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            
            self.progressView.topAnchor.constraint(equalTo: self.nameProgressiveView.bottomAnchor, constant: 12),
            self.progressView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12),
            self.progressView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -12),
            self.progressView.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
//    public func progressViewFunc() {
//        let abs: Float = 0.8
//        progressView.progress = 0 + abs
//    }
}
