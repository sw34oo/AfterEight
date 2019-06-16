//
//  AddRecordLabel.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-09-14.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import UIKit

class AddRecordLabel: UILabel {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabel() {
        font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        textColor = ThemeManager.currentTheme().textColor
        if let font = UIFont(name: "SFCompactDisplay-Medium", size: 20) {
            self.font = UIFontMetrics.default.scaledFont(for: font)
        }
        numberOfLines = 0
        textAlignment = .center
        clipsToBounds = true
        adjustsFontForContentSizeCategory = true

        translatesAutoresizingMaskIntoConstraints = false
    }

}
