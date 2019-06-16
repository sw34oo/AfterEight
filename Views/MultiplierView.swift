//
//  MultiplierView.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-04-13.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import UIKit

class MultiplierView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = false
        setupBaseView()
    }
    
    func setupBaseView() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func draw(_ rect: CGRect) {
        let shadowLayer = CALayer()
        shadowLayer.backgroundColor = ThemeManager.currentTheme().backgroundColor.cgColor
        shadowLayer.cornerRadius = frame.height / 2
        shadowLayer.frame = self.bounds
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0, height: 2)
        shadowLayer.shadowRadius = 4
        shadowLayer.shadowOpacity = 0.5
        layer.addSublayer(shadowLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
