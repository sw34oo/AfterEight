//
//  AppStoreRatingControl.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2017-10-26.
//  Copyright © 2017 Niklas Engsoo. All rights reserved.
//

import UIKit
import StoreKit

class AppStoreRatingControl: SettingsBaseControl {

    
    let ratingButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitleColor(ThemeManager.currentTheme().textColor, for: .normal)
        button.setTitleColor(ThemeManager.currentTheme().tintColor, for: .highlighted)
        button.layer.borderColor = ThemeManager.currentTheme().textColor.cgColor
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
        button.setTitle("App Store Rating", for: .normal)
        button.setTitle("Thanks!", for: .highlighted)
        button.backgroundColor = ThemeManager.currentTheme().textColor.withAlphaComponent(0.2)
        button.layer.cornerRadius = 22.5
        button.layer.borderWidth = Constants.borderWidth
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(appStoreRatingTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    
    
    override func setupView() {
        addSubview(baseView)
        addSubview(ratingButton)
        
        super.layoutSubviews()
        
        baseView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        baseView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        baseView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        baseView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        baseView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 9/10).isActive = true

        ratingButton.centerYAnchor.constraint(equalTo: baseView.centerYAnchor).isActive = true
        ratingButton.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
        ratingButton.widthAnchor.constraint(equalTo: baseView.widthAnchor, multiplier: 8.5/10).isActive = true
        ratingButton.heightAnchor.constraint(equalTo: baseView.heightAnchor, multiplier: 5/10).isActive = true
    }
    
    @objc private func appStoreRatingTapped() {
        SKStoreReviewController.requestReview()
    }
}
