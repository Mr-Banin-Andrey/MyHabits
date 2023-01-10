//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Андрей Банин on 4.1.23..
//

import UIKit

class ProgressCollectionViewCell: UICollectionReusableView {
    
    //MARK: - Properties
    private lazy var nameProgressiveView: UILabel = {
        let label = UILabel()
        label.text = "Всё получится!"
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.progressTintColor = #colorLiteral(red: 0.631372549, green: 0.0862745098, blue: 0.8, alpha: 1)
//        progress.sizeToFit()
        progress.translatesAutoresizingMaskIntoConstraints = false
//        progress.perform(#selector(progressViewFunc), with: nil, afterDelay: 0.2)
        progress.progress = HabitsStore.shared.todayProgress
        return progress
    }()
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.tintColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        
        self.addSubview(self.backView)
        self.addSubview(self.nameProgressiveView)
        self.addSubview(self.progressView)
        
        NSLayoutConstraint.activate([
            
            self.backView.topAnchor.constraint(equalTo: self.topAnchor, constant: 21.5),
            self.backView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.backView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.backView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.nameProgressiveView.topAnchor.constraint(equalTo: self.backView.topAnchor, constant: 12),
            self.nameProgressiveView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor, constant: 16),

            self.progressView.topAnchor.constraint(equalTo: self.nameProgressiveView.bottomAnchor, constant: 12),
            self.progressView.leftAnchor.constraint(equalTo: self.backView.leftAnchor, constant: 16),
            self.progressView.rightAnchor.constraint(equalTo: self.backView.rightAnchor, constant: -16)
        ])
    }
    
    @objc func progressViewFunc() {
//        let abs: Float = 0.8
//        progressView.progress = 0 + abs
    }
}
