//
//  ActionSheetStyleBackgroundView.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-02-09.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import UIKit

class ActionSheetStyleBackgroundView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.backgroundColor = ThemeManager.currentTheme().backgroundColor.cgColor
        layer.cornerRadius = Constants.cornerRadius
        layer.borderColor = ThemeManager.currentTheme().textColor.cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
