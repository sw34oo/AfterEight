//
//  HeaderLabel.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-02-09.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import UIKit

class SmallTextCenteredLabel: UILabel {
    
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
        textAlignment = .center
        adjustsFontSizeToFitWidth = true
        if let myFont = UIFont(name: "SFCompactDisplay-Bold", size: 12) {
            UIFontMetrics(forTextStyle: UIFont.TextStyle.caption2).scaledFont(for: myFont)
            font = myFont
        }
        adjustsFontForContentSizeCategory = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
