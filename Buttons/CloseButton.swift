//
//  CloseButton.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-01-19.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import UIKit


class CloseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCloseButton()
    }
    
    func setupCloseButton() {
        let closeImage = UIImage(named: "close")
        setImage(closeImage, for: .normal)
        tintColor = ThemeManager.currentTheme().tintColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height / 2
        tintColor = ThemeManager.currentTheme().tintColor
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
