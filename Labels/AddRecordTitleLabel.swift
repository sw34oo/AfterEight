//
//  AddRecordTitleLabel.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-05-02.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import UIKit

class AddRecordTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabel() {
        if let font = UIFont(name: "SFCompactDisplay-Bold", size: 24) {
            self.font = UIFontMetrics.default.scaledFont(for: font)
        }
        textColor = ThemeManager.currentTheme().textColor
        textAlignment = .center
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.8
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
