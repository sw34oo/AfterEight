//
//  DateCell.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2017-10-10.
//  Copyright © 2017 Niklas Engsoo. All rights reserved.
//

import UIKit

class DateCell: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let baseView = AddRecordBaseView()
    let dateTextView = AddRecordTextView()
    let strokeView = StrokeView()

    func setupViews() {
        dateTextView.text = Date().fullDate()
        addSubview(baseView)
        addSubview(strokeView)
        addSubview(dateTextView)
        baseView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        baseView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        baseView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        baseView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        strokeView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -4).isActive = true
        strokeView.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
        strokeView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        strokeView.widthAnchor.constraint(equalTo: baseView.widthAnchor, multiplier: 6/10).isActive = true
        
        dateTextView.topAnchor.constraint(equalTo: baseView.topAnchor).isActive = true
        dateTextView.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
        dateTextView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -4).isActive = true
        dateTextView.widthAnchor.constraint(equalTo: baseView.widthAnchor).isActive = true
    }
}

