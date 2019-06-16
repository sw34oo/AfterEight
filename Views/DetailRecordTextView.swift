//
//  DetailRecordTextView.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-10-11.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import UIKit

class DetailRecordTextView: UITextView {
    
    
    private func setupTextView() {
        
        if let myFont = UIFont(name: "SFCompactDisplay-Regular", size: 14) {
            font = UIFontMetrics.default.scaledFont(for: myFont)
        }
        textColor = ThemeManager.currentTheme().textColor
        backgroundColor = UIColor.clear
        textAlignment = .left
        isEditable = false
        isScrollEnabled = true
        contentInset = UIEdgeInsets(top: -8, left: 0, bottom: 0, right: 0)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupTextView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

