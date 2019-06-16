//
//  WeightControl.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2017-10-31.
//  Copyright © 2017 Niklas Engsoo. All rights reserved.
//

import UIKit

protocol WeightUnitDelegate {
    func weightUnitChanged(_ weightUnit: String)
}

let weightUnitNotification = Notification.init(name: Notification.Name(rawValue: "weightUnitNotificationName"))


class WeightControl: SettingsBaseControl {
    
    var weightUnitDelegate: WeightUnitDelegate?
    
    let weightSlider: SettingsSlider = {
        let slider: SettingsSlider = SettingsSlider()
        slider.minimumValue = 10
        slider.maximumValue = 240
        slider.addTarget(self, action: #selector(settingSliderValueChanged(slider:)), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    let weightUnitSwitch: SettingSwitch = {
        let weightSwitch: SettingSwitch = SettingSwitch()
        weightSwitch.addTarget(self, action: #selector(weightUnitSwitchChanged(sender:)), for: .valueChanged)
        weightSwitch.translatesAutoresizingMaskIntoConstraints = false
        return weightSwitch
    }()
    
    let unitLabel = SettingsLabel()
    
    
    override func setupView() {
        addSubview(baseView)
        addSubview(settingsLabel)
        addSubview(weightSlider)
        addSubview(unitLabel)
        addSubview(weightUnitSwitch)
        
        let weightValue = UserDefaults.standard.integer(forKey: weightValueKey)
        let weightFloatValue = Float(weightValue)
        if let weightUnit = UserDefaults.standard.value(forKey: weightUnitKey) {
            settingsLabel.text = "Weight: \(weightValue) \(weightUnit)"
        }
        weightSlider.setValue(weightFloatValue, animated: true)
        
        
        unitLabel.text = "Weight unit: "
        if let weightUnit = UserDefaults.standard.string(forKey: weightUnitKey) {
            unitLabel.text = "Weight unit: \(weightUnit)"
            if weightUnit == "kg" {
                weightUnitSwitch.setOn(true, animated: true)
            } else {
                weightUnitSwitch.setOn(false, animated: true)
            }
        }
        
        baseView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        baseView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        baseView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        baseView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        baseView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 9/10).isActive = true
        
        settingsLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 8).isActive = true
        settingsLabel.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
        settingsLabel.heightAnchor.constraint(equalTo: baseView.heightAnchor, multiplier: 1.25/10).isActive = true
        settingsLabel.widthAnchor.constraint(equalTo: baseView.widthAnchor, multiplier: 8/10).isActive = true
        
        weightSlider.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
        weightSlider.widthAnchor.constraint(equalTo: baseView.widthAnchor, multiplier: 9/10).isActive = true
        weightSlider.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 24).isActive = true
        
        unitLabel.topAnchor.constraint(equalTo: weightSlider.bottomAnchor, constant: 4).isActive = true
        unitLabel.centerXAnchor.constraint(equalTo: settingsLabel.centerXAnchor).isActive = true
        unitLabel.heightAnchor.constraint(equalTo: settingsLabel.heightAnchor).isActive = true
        unitLabel.widthAnchor.constraint(equalTo: settingsLabel.widthAnchor).isActive = true
        
        weightUnitSwitch.topAnchor.constraint(equalTo: unitLabel.bottomAnchor, constant: 8).isActive = true
        weightUnitSwitch.centerXAnchor.constraint(equalTo: settingsLabel.centerXAnchor).isActive = true
        weightUnitSwitch.bottomAnchor.constraint(equalTo: baseView.bottomAnchor).isActive = true
        
    }
    
    @objc func settingSliderValueChanged(slider: UISlider) {
        
        let roundedValue = round(slider.value / 20) * 20
        slider.value = roundedValue
        let weightValue: Int = lrintf(roundedValue)
        UserDefaults.standard.set(weightValue, forKey: weightValueKey)
        if let weightUnit = UserDefaults.standard.string(forKey: weightUnitKey) {
            settingsLabel.text = "Weight: \(weightValue) \(weightUnit)"
        }
        
    }
    
    @objc func weightUnitSwitchChanged(sender: UISwitch) {
        var weightUnit = "kg"
        
        if sender.isOn {
            UserDefaults.standard.set(weightUnit, forKey: weightUnitKey)
            unitLabel.text = "Weight unit: \(weightUnit)"
        } else {
            weightUnit = "lb"
            UserDefaults.standard.set(weightUnit, forKey: weightUnitKey)
            unitLabel.text = "Weight unit: \(weightUnit)"
        }
        updateWeightSlider(weightUnit: weightUnit)
        NotificationCenter.default.post(name: weightUnitNotification.name, object: nil)
    }
    
    func updateWeightSlider(weightUnit: String) {
        var weightValue = 0
        
        if weightUnit == "kg" {
            let weight = Double(weightSlider.value) * poundsMultiplier
            UserDefaults.standard.set(weight, forKey: weightValueKey)
            weightValue = Int(weight)
            UIView.animate(withDuration: 0.5) {
                self.weightSlider.setValue(Float(weight), animated: true)
                self.settingsLabel.text = "Weight: \(weightValue) \(weightUnit)"
            }
        } else if weightUnit == "lb" {
            let weight = Double(weightSlider.value) / poundsMultiplier
            UserDefaults.standard.set(weight, forKey: weightValueKey)
            weightValue = Int(weight)
            UIView.animate(withDuration: 0.5) {
                self.weightSlider.setValue(Float(weight), animated: true)
                self.settingsLabel.text = "Weight: \(weightValue) \(weightUnit)"
            }
            
        }
        
    }
    
}
