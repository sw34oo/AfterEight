//
//  BaseView.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-08-30.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import UIKit

class AddRecordBaseView: UIVisualEffectView {
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        setupBaseView()
    }
    
    func setupBaseView() {
        effect = UIBlurEffect(style: .extraLight)
        frame = self.bounds
        layer.borderWidth = Constants.borderWidth
        layer.cornerRadius = Constants.cornerRadius
        layer.borderColor = ThemeManager.currentTheme().whiteColor.withAlphaComponent(0.5).cgColor
        layer.masksToBounds = true
        alpha = 0.20
        translatesAutoresizingMaskIntoConstraints = false
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

