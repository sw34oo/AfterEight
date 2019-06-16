//
//  SettingsSlider.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-08-25.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import UIKit

class SettingsSlider: UISlider {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        thumbTintColor = ThemeManager.currentTheme().textColor
        maximumTrackTintColor = ThemeManager.currentTheme().textColor
        minimumTrackTintColor = ThemeManager.currentTheme().tintColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 5.0))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }
    
    override func draw(_ rect: CGRect) {
        self.thumbTintColor = ThemeManager.currentTheme().textColor
        self.maximumTrackTintColor = ThemeManager.currentTheme().mainColor
        self.minimumTrackTintColor = ThemeManager.currentTheme().tintColor
    }
}
