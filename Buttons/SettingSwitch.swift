//
//  SettingSwitch.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-09-23.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import UIKit

class SettingSwitch: UISwitch {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSwitch()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSwitch() {
        tintColor = ThemeManager.currentTheme().textColor
        onTintColor = ThemeManager.currentTheme().textColor
        thumbTintColor = ThemeManager.currentTheme().tintColor
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func draw(_ rect: CGRect) {
        tintColor = ThemeManager.currentTheme().textColor
        onTintColor = ThemeManager.currentTheme().textColor
        thumbTintColor = ThemeManager.currentTheme().tintColor
    }
}
