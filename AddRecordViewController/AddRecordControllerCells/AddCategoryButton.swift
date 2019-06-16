//
//  AddCategoryButton.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-06-12.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import UIKit

class AddCategoryButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    func setupView() {
        
        if let font = UIFont(name: "SFCompactDisplay-Medium", size: 16) {
            titleLabel?.font = UIFontMetrics.default.scaledFont(for: font)
        }
        setTitleColor(ThemeManager.currentTheme().tintColor, for: .normal)
        setTitleColor(ThemeManager.currentTheme().textColor, for: .selected)
        centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        widthAnchor.constraint(equalToConstant: 90).isActive = true
    }
}
