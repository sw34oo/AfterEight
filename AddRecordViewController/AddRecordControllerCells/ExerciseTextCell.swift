//
//  ExerciseTextCell.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2017-10-10.
//  Copyright © 2017 Niklas Engsoo. All rights reserved.
//

import UIKit

class ExerciseTextCell: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let baseView = AddRecordBaseView()
    let strokeView = StrokeView()
    let exerciseTextView = AddRecordTextView()
    
    let moreInfoButton: MoreButton = {
        let button = MoreButton()
        button.addTarget(self, action: #selector(AddRecordViewController.showInfoForExercise), for: .touchUpInside)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupViews() {
        backgroundColor = UIColor.clear
        addSubview(baseView)
        addSubview(strokeView)
        addSubview(exerciseTextView)
        addSubview(moreInfoButton)
        
        baseView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        baseView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        strokeView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -4).isActive = true
        strokeView.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
        strokeView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        strokeView.widthAnchor.constraint(equalTo: baseView.widthAnchor, multiplier: 6/10).isActive = true
        
        exerciseTextView.topAnchor.constraint(equalTo: baseView.topAnchor).isActive = true
        exerciseTextView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 48).isActive = true
        exerciseTextView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor).isActive = true
        exerciseTextView.trailingAnchor.constraint(equalTo: moreInfoButton.leadingAnchor, constant: -8).isActive = true
        
        moreInfoButton.centerYAnchor.constraint(equalTo: baseView.centerYAnchor).isActive = true
        moreInfoButton.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -16).isActive = true
        moreInfoButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        moreInfoButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
    }
}

