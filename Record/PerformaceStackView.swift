//
//  PerformaceStackView.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-09-05.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import UIKit

class PerformanceStackView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupPerformanceView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var performance: Int = 3 {
        didSet {
            setupPerformanceView()
        }
    }
    
    var performanceImages = [UIImageView]()
    
    
    func setupPerformanceView() {
        performanceImages.forEach { (image) in
            image.removeFromSuperview()
        }
        performanceImages.removeAll()
        
        let emptyCircle = ThemeManager.currentTheme().smallEmptyCircle
        let filledCircle = ThemeManager.currentTheme().smallFilledCircle
        
        for count in 1...5 {
            
            let imageView = UIImageView()
            
                if performance >= count  {
                    imageView.image = filledCircle.drawCircle()
                    performanceImages.append(imageView)
                } else {
                    imageView.image = emptyCircle.drawCircle()
                    performanceImages.append(imageView)
                }
            }
        
        let performanceStackView = UIStackView(arrangedSubviews: performanceImages.reversed())
        performanceStackView.isLayoutMarginsRelativeArrangement = true
        performanceStackView.axis = .vertical
        performanceStackView.spacing = 4
        performanceStackView.distribution = .fillEqually
        performanceStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(performanceStackView)
        performanceStackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        performanceStackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    

}






