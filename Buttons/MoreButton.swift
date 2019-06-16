//
//  MoreButton.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-10-07.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import UIKit

class MoreButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMoreButton()
    }
    
    func setupMoreButton() {
        setTitle("i", for: UIControl.State.normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        setTitleColor(ThemeManager.currentTheme().textColor, for: UIControl.State.normal)
        setTitleColor(ThemeManager.currentTheme().tintColor, for: UIControl.State.highlighted)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height / 2
        layer.borderWidth = Constants.borderWidth
        layer.borderColor = ThemeManager.currentTheme().tintColor.cgColor
        layer.backgroundColor = ThemeManager.currentTheme().accentColor.cgColor
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
