//
//  MyRoundedView.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-03-28.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import UIKit

class MyRoundedView: UIView {
    
    
    var stroke = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBaseView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func setupBaseView() {
        layer.backgroundColor = ThemeManager.currentTheme().backgroundColor.cgColor
        layer.cornerRadius = Constants.cornerRadius
        layer.masksToBounds = true
        layer.borderWidth = 1
        alpha = 0.9
        translatesAutoresizingMaskIntoConstraints = false
        
        stroke.backgroundColor = ThemeManager.currentTheme().tintColor
        stroke.layer.cornerRadius = 1.5
        stroke.layer.masksToBounds = true
        stroke.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stroke)
        
        stroke.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        stroke.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stroke.heightAnchor.constraint(equalToConstant: 3).isActive = true
        stroke.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 6/10).isActive = true
    }
}
