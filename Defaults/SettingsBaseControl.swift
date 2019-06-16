//
//  SettingsBaseCell.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-02-11.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import UIKit

class SettingsBaseControl: UIControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let baseView = AddRecordBaseView()
    let settingsLabel = SettingsLabel()
    
    func setupView() {
        self.layoutIfNeeded()
    }
}
