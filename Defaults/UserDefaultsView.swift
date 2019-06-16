//
//  UserSettingsViewController.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2017-10-25.
//  Copyright © 2017 Niklas Engsoo. All rights reserved.
//

import UIKit

let setValueKey = "setValue"
let repValueKey = "repValue"
let weightValueKey = "weightValue"
let weightUnitKey = "weightUnit"
let poundsMultiplier: Double = 0.45359237

class UserDefaultsView: NSObject {
    
    
    let defaultsBackgroundView = UIView()
    var visualEffectView = UIVisualEffectView(effect: nil)
    var defaultsStackView = UIStackView()
    let headerView = DefaultsHeaderLabel()
    let repControl = RepControl()
    let setControl = SetControl()
    let appStoreRatingControl = AppStoreRatingControl()
    let weightControl = WeightControl()
    
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupSettingsView() {

        if let window = UIApplication.shared.keyWindow {
            
            let blurEffect = UIBlurEffect(style: .dark)
            visualEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeSettingsView)))
            visualEffectView.effect = blurEffect
            window.addSubview(visualEffectView)
            visualEffectView.frame = window.frame
            visualEffectView.alpha = 0
            
            let width: CGFloat = window.frame.width / 2            
            var stackViewHeight: CGFloat = 0
            
            let controls = [headerView, repControl, setControl, weightControl, appStoreRatingControl]
            
            defaultsStackView.isLayoutMarginsRelativeArrangement = true
            defaultsStackView.axis = .vertical
            defaultsStackView.distribution = .equalSpacing
            defaultsStackView.spacing = 8
            defaultsStackView.alpha = 0
            
            controls.forEach { (control) in
                stackViewHeight += (control.frame.height + 8)
                defaultsStackView.addArrangedSubview(control)
            }
            defaultsStackView.frame = CGRect(x: -width, y: 48, width: width, height: 520)
            window.addSubview(defaultsStackView)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.4, options: .curveEaseIn, animations: {
                self.visualEffectView.alpha = 1
                self.defaultsStackView.alpha = 1
                self.defaultsStackView.frame = CGRect(x: 0, y: 48, width: self.defaultsStackView.frame.width, height: self.defaultsStackView.frame.height)
                
            })
        }
    }
    
    
    @objc func closeSettingsView() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.visualEffectView.alpha = 0
            self.defaultsStackView.alpha = 0
            self.defaultsStackView.frame = CGRect(x: -self.defaultsStackView.frame.width, y: 48, width: self.defaultsStackView.frame.width, height: self.defaultsStackView.frame.height)
        })
    }
}

