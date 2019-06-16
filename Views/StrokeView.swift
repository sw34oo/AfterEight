//
//  StrokeView.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-04-07.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import UIKit

class StrokeView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStrokeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStrokeView() {
        backgroundColor = ThemeManager.currentTheme().tintColor
        layer.cornerRadius = 1.5
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
