//
//  AddRecordTextViewDelegate.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2017-12-03.
//  Copyright © 2017 Niklas Engsoo. All rights reserved.
//

import UIKit


extension AddRecordViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == "add a note..." {
            textView.text = ""
            textView.textColor = ThemeManager.currentTheme().textColor
        }
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "add a note..."
            textView.textColor = ThemeManager.currentTheme().textColor.withAlphaComponent(0.6)
        }
        textView.resignFirstResponder()
    }
    
}
