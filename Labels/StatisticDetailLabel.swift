//
//  StatisticDetailLabel.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-09-27.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import UIKit

class StatisticDetailLabel: UILabel {
    
    let theme = ThemeManager.currentTheme()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabel() {
        font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1)
        textColor = ThemeManager.currentTheme().textColor
        numberOfLines = 1
        adjustsFontSizeToFitWidth = true
        textAlignment = .center
        clipsToBounds = true
        
        if let caption = UIFont(name: "SFCompactDisplay-Medium", size: 13) {
            UIFontMetrics(forTextStyle: UIFont.TextStyle.caption1).scaledFont(for: caption)
            self.font = caption
        }
        adjustsFontForContentSizeCategory = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
