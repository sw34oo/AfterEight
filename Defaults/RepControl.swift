//
//  RepControl.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2017-10-31.
//  Copyright © 2017 Niklas Engsoo. All rights reserved.
//

import UIKit

class RepControl: SettingsBaseControl {

    
    let repStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 3
        stepper.maximumValue = 50
        stepper.isContinuous = true
        stepper.tintColor = ThemeManager.currentTheme().tintColor
        stepper.wraps = true
        stepper.addTarget(self, action: #selector(stepperValueChanged(stepper:)), for: .valueChanged)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()

    
    override func setupView() {
        addSubview(baseView)
        addSubview(settingsLabel)
        addSubview(repStepper)
        
        let repValue = UserDefaults.standard.integer(forKey: repValueKey)
        repStepper.value = Double(repValue)
        settingsLabel.text = "Repetitions: \(repValue)"
        
        baseView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        baseView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        baseView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        baseView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        baseView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 9/10).isActive = true

        settingsLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 8).isActive = true
        settingsLabel.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
        settingsLabel.heightAnchor.constraint(equalTo: baseView.heightAnchor, multiplier: 2.5/10).isActive = true
        settingsLabel.widthAnchor.constraint(equalTo: baseView.widthAnchor, multiplier: 9/10).isActive = true
        
        repStepper.centerXAnchor.constraint(equalTo: settingsLabel.centerXAnchor, constant: -8).isActive = true
        repStepper.widthAnchor.constraint(equalTo: baseView.widthAnchor, multiplier: 5/10).isActive = true
        repStepper.centerYAnchor.constraint(equalTo: baseView.centerYAnchor, constant: 16).isActive = true
    }
    
    
    @objc func stepperValueChanged(stepper: UIStepper) {

        let repValue: Int = Int(stepper.value)
        UserDefaults.standard.set(repValue, forKey: repValueKey)
        settingsLabel.text = "Repetitions: \(repValue)"
    }
    
}
