//
//  Extensions.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2017-11-04.
//  Copyright © 2017 Niklas Engsoo. All rights reserved.


import UIKit

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(displayP3Red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}



extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITextView {
    func setToolbar() {
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.width, height: 30))
        toolbar.sizeToFit()
        toolbar.barStyle = .blackTranslucent
        toolbar.backgroundColor = ThemeManager.currentTheme().tintColor
        let flexSpace = UIBarButtonItem(barButtonSystemItem:UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneButtonAction))
        doneBtn.tintColor = ThemeManager.currentTheme().textColor
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        self.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction() {
        self.endEditing(true)
    }
}


extension String {
    var html2Attributed: NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
}

extension Date {
    
    func shortDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.locale = NSLocale.current
        return formatter.string(from: self)
    }
    
    func mediumDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = NSLocale.current
        return formatter.string(from: self)
    }
    
    func fullDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.locale = NSLocale.current
        let dateString = formatter.string(from: self)
        return dateString
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension FileManager {
    static var documentDirectoryURL: URL {
        return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}


extension UIView {
    func setShadow() {
        let shadowLayer = CALayer()
        shadowLayer.backgroundColor = ThemeManager.currentTheme().backgroundColor.cgColor
        shadowLayer.cornerRadius = Constants.cornerRadius
        shadowLayer.frame = self.bounds
        shadowLayer.cornerRadius = frame.height / 2
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = CGSize(width: 1, height: 6)
        shadowLayer.shadowRadius = 4
        shadowLayer.shadowOpacity = 1
        shadowLayer.contents = self
        
        self.layer.addSublayer(shadowLayer)
    }
}


