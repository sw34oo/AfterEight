//
//  MoreInfoCloseButton.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-02-07.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import UIKit

class MoreInfoCloseButton: UIButton {
    
    let shadowLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCloseButton()
    }

    
    func setupCloseButton() {
        let textColor = ThemeManager.currentTheme().textColor
        let invertedTextColor = ThemeManager.currentTheme().invertedTextColor
        setTitle("Close", for: .normal)
        setTitle("Closing...", for: .highlighted)
        setTitleColor(textColor, for: .normal)
        setTitleColor(invertedTextColor, for: .highlighted)
        isHidden = false
        translatesAutoresizingMaskIntoConstraints = false
        layer.insertSublayer(shadowLayer, below: self.layer)
    }
    
    
    override func draw(_ rect: CGRect) {
        
        shadowLayer.backgroundColor = ThemeManager.currentTheme().accentColor.cgColor
        shadowLayer.cornerRadius = Constants.cornerRadius
        shadowLayer.frame = self.bounds
        shadowLayer.cornerRadius = frame.height / 2
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = CGSize(width: 1, height: 6)
        shadowLayer.shadowRadius = 4
        shadowLayer.shadowOpacity = 0.4
        shadowLayer.contents = self
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
