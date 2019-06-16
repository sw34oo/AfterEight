//
//  AlertLabel.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-04-06.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import UIKit

class AlertLabel: UILabel {
    
    override var intrinsicContentSize: CGSize {
        let originalContentSize = super.intrinsicContentSize
        let height = originalContentSize.height + 8
        let width = originalContentSize.width + 32
        layer.cornerRadius = height / 2
        layer.masksToBounds = true
        return CGSize(width: width, height: height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAlertLabel()
        
        
    }
    
    func setupAlertLabel() {
        font = .systemFont(ofSize: 14, weight: .heavy)
        backgroundColor = ThemeManager.currentTheme().darkAccentColor
        textColor = UIColor.black
        textAlignment = .center
        alpha = 0
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
