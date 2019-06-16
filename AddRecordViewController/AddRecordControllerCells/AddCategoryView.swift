//
//  AddCategoryCollectionViewCell.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-10-05.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import UIKit

class AddCategoryView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let baseView = AddRecordBaseView()
    let strokeView = StrokeView()
    
    func setupView() {
        addSubview(baseView)
        addSubview(strokeView)
        
        baseView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        baseView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        baseView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        strokeView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -4).isActive = true
        strokeView.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
        strokeView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        strokeView.widthAnchor.constraint(equalTo: baseView.widthAnchor, multiplier: 5/10).isActive = true
    }
}
