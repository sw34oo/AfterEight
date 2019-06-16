//
//  AddRecordTextView.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-04-13.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import Foundation


import UIKit

class AddRecordTextView: UITextView {
    
    override var contentSize: CGSize {
        didSet {
            var topInset = (bounds.size.height - contentSize.height * zoomScale) / 2.0
            topInset = max(0, topInset)
            contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
        }
    }
    
    private func setupTextView() {
        textContainer.maximumNumberOfLines = 2
        isEditable = false
        if let font = UIFont(name: "SFCompactDisplay-Bold", size: 20) {
            self.font = UIFontMetrics.default.scaledFont(for: font)
        }
        textColor = ThemeManager.currentTheme().textColor
        backgroundColor = UIColor.clear
        textAlignment = .center
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
