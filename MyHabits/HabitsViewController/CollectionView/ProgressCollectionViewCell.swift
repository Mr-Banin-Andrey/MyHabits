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
    
    lazy var progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.progressTintColor = #colorLiteral(red: 0.631372549, green: 0.0862745098, blue: 0.8, alpha: 1)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.progress = HabitsStore.shared.todayProgress
        progress.tag = 123
//        progress.performSelector(onMainThread: #selector(progressDownload), with: self, waitUntilDone: true)
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
        
        self.contentView.addSubview(self.nameProgressiveView)
        self.contentView.addSubview(self.progressView)
        
        NSLayoutConstraint.activate([
            
            self.nameProgressiveView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            self.nameProgressiveView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),

            self.progressView.topAnchor.constraint(equalTo: self.nameProgressiveView.bottomAnchor, constant: 12),
            self.progressView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 16),
            self.progressView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16)
        ])
    }
}
