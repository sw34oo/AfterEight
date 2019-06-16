//
//  WeightTextCell.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2017-10-10.
//  Copyright © 2017 Niklas Engsoo. All rights reserved.
//

import UIKit

class WeightTextCell: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    let userDefaults = UserDefaults.standard
    
    let baseView: UIView = {
        let view: UIView = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let setsTextLabel = AddRecordTextView()
    let repsTextLabel = AddRecordTextView()
    let weightTextLabel = AddRecordTextView()
    
    let multiplierView = MultiplierView()
    let secondMultiplierView = MultiplierView()
    let multiplierLabel = MultiplierLabel()
    let secondMultiplierLabel = MultiplierLabel()
    
    
    let setView = AddRecordBaseView()
    let repView = AddRecordBaseView()
    let weightView = AddRecordBaseView()
    
    
    
    func setupViews() {
        backgroundColor = UIColor.clear
        addSubview(baseView)
        
        
        let weightViewStackView = UIStackView()
        weightViewStackView.distribution = .fillEqually
        weightViewStackView.spacing = 8
        weightViewStackView.axis = .horizontal
        weightViewStackView.contentMode = .scaleToFill
        weightViewStackView.alignment = .fill
        weightViewStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weightViewStackView)
        
        let weightStackView = UIStackView()
        weightStackView.distribution = .fillEqually
        weightStackView.axis = .horizontal
        weightStackView.spacing = 8
        weightStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weightStackView)
        
        
    
        let weightViews = [setView, repView, weightView]
        weightViews.forEach { (view) in
            weightViewStackView.addArrangedSubview(view)
        }
        
        let weightTextLabels = [repsTextLabel, setsTextLabel, weightTextLabel]
        weightTextLabels.forEach({ (label) in
            weightStackView.addArrangedSubview(label)
        })
        
        addSubview(multiplierView)
        addSubview(secondMultiplierView)
        addSubview(multiplierLabel)
        addSubview(secondMultiplierLabel)
        
        
        
        baseView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        baseView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        weightViewStackView.centerYAnchor.constraint(equalTo: baseView.centerYAnchor).isActive = true
        weightViewStackView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor).isActive = true
        weightViewStackView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor).isActive = true
        weightViewStackView.heightAnchor.constraint(equalTo: baseView.heightAnchor).isActive = true
        
        weightStackView.centerYAnchor.constraint(equalTo: weightViewStackView.centerYAnchor, constant: 6).isActive = true
        weightStackView.leadingAnchor.constraint(equalTo: weightViewStackView.leadingAnchor).isActive = true
        weightStackView.trailingAnchor.constraint(equalTo: weightViewStackView.trailingAnchor).isActive = true
        weightStackView.heightAnchor.constraint(equalTo: weightViewStackView.heightAnchor).isActive = true
        
        multiplierView.centerYAnchor.constraint(equalTo: weightViewStackView.centerYAnchor).isActive = true
        multiplierView.centerXAnchor.constraint(equalTo: repsTextLabel.trailingAnchor, constant: 4).isActive = true
        multiplierView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        multiplierView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        
        secondMultiplierView.centerYAnchor.constraint(equalTo: weightViewStackView.centerYAnchor).isActive = true
        secondMultiplierView.centerXAnchor.constraint(equalTo: setsTextLabel.trailingAnchor, constant: 4).isActive = true
        secondMultiplierView.heightAnchor.constraint(equalToConstant: 28).isActive = true
        secondMultiplierView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        
        multiplierLabel.centerYAnchor.constraint(equalTo: multiplierView.centerYAnchor).isActive = true
        multiplierLabel.centerXAnchor.constraint(equalTo: multiplierView.centerXAnchor).isActive = true
        multiplierLabel.heightAnchor.constraint(equalToConstant: 28).isActive = true
        multiplierLabel.widthAnchor.constraint(equalToConstant: 28).isActive = true
        
        secondMultiplierLabel.centerYAnchor.constraint(equalTo: secondMultiplierView.centerYAnchor).isActive = true
        secondMultiplierLabel.centerXAnchor.constraint(equalTo: secondMultiplierView.centerXAnchor).isActive = true
        secondMultiplierLabel.heightAnchor.constraint(equalToConstant: 28).isActive = true
        secondMultiplierLabel.widthAnchor.constraint(equalToConstant: 28).isActive = true
    }
    
    
    func setupWeightTextCell(vc: AddRecordViewController) {
            let userSet = userDefaults.integer(forKey: setValueKey)
            vc.selectedSet = userSet
            let userRep = userDefaults.integer(forKey: repValueKey)
            vc.selectedRep = userRep
            let userWeight = userDefaults.integer(forKey: weightValueKey)
            vc.selectedWeight = Double(userWeight)
            
            let weightString = String(Int(vc.selectedWeight))
            let weightUnit = getWeightUnit()
        
        
        let repAttributedText = AttributedText(numberSize: 40, captionSize: 16, firstString: String(vc.selectedRep), secondString: "rep", lineHeightMultiple: 0.75)
        
        let setAttributedText = AttributedText(numberSize: 40, captionSize: 16, firstString: String(vc.selectedSet), secondString: "set", lineHeightMultiple: 0.75)
        
        let weightAttributedText = AttributedText(numberSize: 40, captionSize: 16, firstString: weightString, secondString: weightUnit, lineHeightMultiple: 0.75)

        repsTextLabel.attributedText = repAttributedText.setAttributedText()
        setsTextLabel.attributedText = setAttributedText.setAttributedText()
        weightTextLabel.attributedText = weightAttributedText.setAttributedText()
        
    }
    
    
    
}






