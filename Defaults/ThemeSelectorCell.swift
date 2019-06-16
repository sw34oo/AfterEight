//
//  ThemeSelectorCell.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-09-11.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import UIKit

class ThemeSelectorCell: SettingsBaseControl {
    
    let themeSwitch: SettingSwitch = {
        let weightSwitch: SettingSwitch = SettingSwitch()
//        weightSwitch.addTarget(self, action: #selector(UserDefaultsView.themeSwitchChanged(_:)), for: .valueChanged)
        weightSwitch.translatesAutoresizingMaskIntoConstraints = false
        return weightSwitch
    }()
    
    
    override func setupView() {
        addSubview(baseView)
        addSubview(settingsLabel)
        addSubview(themeSwitch)
        
        baseView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        baseView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        baseView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 9/10).isActive = true
        baseView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 9/10).isActive = true
        
        settingsLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 8).isActive = true
        settingsLabel.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
        settingsLabel.heightAnchor.constraint(equalTo: baseView.heightAnchor, multiplier: 2.5/10).isActive = true
        settingsLabel.widthAnchor.constraint(equalTo: baseView.widthAnchor, multiplier: 9/10).isActive = true
        
        themeSwitch.centerYAnchor.constraint(equalTo: baseView.centerYAnchor, constant: 16).isActive = true
        themeSwitch.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
    }
}
