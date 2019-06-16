//
//  SettingsHeaderLabel.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-09-27.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import UIKit

class SettingsLabel: UILabel {
    
    let theme = ThemeManager.currentTheme()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabel() {
        textColor = theme.textColor
        numberOfLines = 1
        adjustsFontSizeToFitWidth = true
        textAlignment = .center
        clipsToBounds = true
        
        if let font = UIFont(name: "SFCompactDisplay-Medium", size: 16) {
            self.font = UIFontMetrics.default.scaledFont(for: font)
        }
        adjustsFontForContentSizeCategory = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
}
