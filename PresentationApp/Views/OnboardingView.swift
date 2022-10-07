//
//  OnboardingView.swift
//  PresentationApp
//
//  Created by Vladimir Sekerko on 07.10.2022.
//

import UIKit

class OnboardingView: UIView {
    
    private let pageLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(pageLabel)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setPageLabelText(text: String) {
        pageLabel.text = text
    }
    
    public func setPageLabelTransform(transform: CGAffineTransform) {
        pageLabel.transform = transform
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            pageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            pageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            pageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            pageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
