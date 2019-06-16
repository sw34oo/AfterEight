//
//  AddRecordBackgroundImageView.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-03-28.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import UIKit

class AddRecordBackgroundImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        image = UIImage(named: "bgImage")
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


