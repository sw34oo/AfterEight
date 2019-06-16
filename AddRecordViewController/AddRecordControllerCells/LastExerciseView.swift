//
//  LastExerciseView.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-04-29.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import UIKit


class LastExerciseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLastExerciseView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let baseView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = ThemeManager.currentTheme().backgroundColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let setsTextLabel = AddRecordLabel()
    let repsTextLabel = AddRecordLabel()
    let weightTextLabel = AddRecordLabel()
    
    let multiplierView = MultiplierView()
    let secondMultiplierView = MultiplierView()
    let firstMultiplierLabel = MultiplierLabel()
    let secondMultiplierLabel = MultiplierLabel()
    
    let setView = AddRecordBaseView()
    let repView = AddRecordBaseView()
    let weightView = AddRecordBaseView()
    
    
    let lastExerciseHeader = SmallTextCenteredLabel()
    
    let multiplierSize: CGFloat = 18
    
    private func setupLastExerciseView() {

        let weightViewStackView = UIStackView()
        weightViewStackView.distribution = .fillEqually
        weightViewStackView.spacing = 8
        weightViewStackView.axis = .horizontal
        weightViewStackView.contentMode = .scaleToFill
        weightViewStackView.alignment = .fill
        weightViewStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let weightStackView = UIStackView()
        weightStackView.distribution = .fillEqually
        weightStackView.axis = .horizontal
        weightStackView.spacing = 8
        weightStackView.translatesAutoresizingMaskIntoConstraints = false

        
        addSubview(baseView)
        lastExerciseHeader.textAlignment = .center
        baseView.addSubview(lastExerciseHeader)
        baseView.addSubview(weightViewStackView)
        baseView.addSubview(weightStackView)
        baseView.addSubview(multiplierView)
        baseView.addSubview(secondMultiplierView)
        baseView.addSubview(firstMultiplierLabel)
        baseView.addSubview(secondMultiplierLabel)
        
        lastExerciseHeader.topAnchor.constraint(equalTo: self.topAnchor, constant: 44).isActive = true
        lastExerciseHeader.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lastExerciseHeader.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        let weightViews = [setView, repView, weightView]
        weightViews.forEach { (view) in
            view.alpha = 0.8
            weightViewStackView.addArrangedSubview(view)
        }
        
        let weightTextLabels = [repsTextLabel, setsTextLabel, weightTextLabel]
        weightTextLabels.forEach({ (label) in
            weightStackView.addArrangedSubview(label)
        })
        
        baseView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        weightViewStackView.topAnchor.constraint(equalTo: lastExerciseHeader.bottomAnchor, constant: 4).isActive = true
        weightViewStackView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 64).isActive = true
        weightViewStackView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -64).isActive = true
        weightViewStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        weightStackView.centerYAnchor.constraint(equalTo: weightViewStackView.centerYAnchor, constant: 2).isActive = true
        weightStackView.leadingAnchor.constraint(equalTo: weightViewStackView.leadingAnchor).isActive = true
        weightStackView.trailingAnchor.constraint(equalTo: weightViewStackView.trailingAnchor).isActive = true
        weightStackView.heightAnchor.constraint(equalTo: weightViewStackView.heightAnchor).isActive = true
        
        
        multiplierView.centerYAnchor.constraint(equalTo: weightViewStackView.centerYAnchor).isActive = true
        multiplierView.centerXAnchor.constraint(equalTo: repsTextLabel.trailingAnchor, constant: 4).isActive = true
        multiplierView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        multiplierView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        secondMultiplierView.centerYAnchor.constraint(equalTo: weightViewStackView.centerYAnchor).isActive = true
        secondMultiplierView.centerXAnchor.constraint(equalTo: setsTextLabel.trailingAnchor, constant: 4).isActive = true
        secondMultiplierView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        secondMultiplierView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        firstMultiplierLabel.centerYAnchor.constraint(equalTo: multiplierView.centerYAnchor).isActive = true
        firstMultiplierLabel.centerXAnchor.constraint(equalTo: multiplierView.centerXAnchor).isActive = true
        firstMultiplierLabel.heightAnchor.constraint(equalToConstant: multiplierSize).isActive = true
        firstMultiplierLabel.widthAnchor.constraint(equalToConstant: multiplierSize).isActive = true
        
        secondMultiplierLabel.centerYAnchor.constraint(equalTo: secondMultiplierView.centerYAnchor).isActive = true
        secondMultiplierLabel.centerXAnchor.constraint(equalTo: secondMultiplierView.centerXAnchor).isActive = true
        secondMultiplierLabel.heightAnchor.constraint(equalToConstant: multiplierSize).isActive = true
        secondMultiplierLabel.widthAnchor.constraint(equalToConstant: multiplierSize).isActive = true
    }
    
}
