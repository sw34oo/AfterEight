//
//  MultiplierLabel.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-09-30.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import UIKit

class MultiplierLabel: UILabel {
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        text = "✕"
        font = UIFont.boldSystemFont(ofSize: 22)
        textAlignment = .center
        textColor = ThemeManager.currentTheme().tintColor
        translatesAutoresizingMaskIntoConstraints = false
    }

}


