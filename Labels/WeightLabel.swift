//
//  WeightLabel.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-09-14.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import UIKit

class WeightLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textAlignment = .center
        textColor = ThemeManager.currentTheme().textColor
        adjustsFontForContentSizeCategory = true
        numberOfLines = 2
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}
