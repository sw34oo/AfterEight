//
//  AddRecordTextView.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-10-10.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import UIKit

class AddRecordNotesTextView: UITextView {
    
    private func setupTextView() {
        contentInset = UIEdgeInsets.init(top: 0, left: 8, bottom: 4, right: 4)
        layer.masksToBounds = true
        font = UIFont.systemFont(ofSize: 16)
        textColor = ThemeManager.currentTheme().textColor.withAlphaComponent(0.7)
        backgroundColor = UIColor.clear
        textAlignment = .left
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
