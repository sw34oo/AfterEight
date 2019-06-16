//
//  PerformanceControl.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-08-22.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import UIKit

class PerformanceControl: UIControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
        updateButtonSelectionStates()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private var performanceButtons = [UIButton]()
    
    var rating: Int = 0 {
        didSet {
            setupButtons()
        }
    }
    
    var ringCount = 5
    
    
    func updateButtonSelectionStates() {
        for (index, button) in performanceButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
    
    @objc func performanceButtonTapped(button: UIButton) {
        guard let index = performanceButtons.firstIndex(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(performanceButtons)")
        }
        
        let notification = UINotificationFeedbackGenerator()
        let selectedPerformance = index + 1
        
        if selectedPerformance == rating {
            rating = 0
            notification.notificationOccurred(.error)
        } else {
            rating = selectedPerformance
            notification.notificationOccurred(.success)
        }
        updateButtonSelectionStates()
    }
    
    let baseView = AddRecordBaseView()
    
    let emptyCircle: Circle = ThemeManager.currentTheme().emptyCircle
    let highlightedCircle: Circle = ThemeManager.currentTheme().highlightedCircle
    let selectedCircle: Circle = ThemeManager.currentTheme().selectedCircle
    
    
    func setupButtons() {
        
        
        performanceButtons.forEach({ (button) in
            button.removeFromSuperview()
        })
        performanceButtons.removeAll()
        
        let performanceStackView = UIStackView()
        performanceStackView.translatesAutoresizingMaskIntoConstraints = false
        performanceStackView.axis = .horizontal
        performanceStackView.alignment = .fill
        performanceStackView.distribution = .fillEqually
        
        let emptyImage = emptyCircle.drawCircle()
        let highlightedImage = highlightedCircle.drawCircle()
        let selectedImage = selectedCircle.drawCircle()
        
        for index in 0..<ringCount {
            let performanceButton: UIButton = UIButton()
            performanceButton.setImage(emptyImage, for: .normal)
            performanceButton.setImage(highlightedImage, for: .highlighted)
            performanceButton.setImage(selectedImage, for: .selected)
            performanceButton.accessibilityLabel = "Set \(index + 1) performance rating"
            performanceButton.addTarget(self, action: #selector(PerformanceControl.performanceButtonTapped(button:)), for: .touchUpInside)
            performanceButtons.append(performanceButton)
            performanceStackView.addArrangedSubview(performanceButton)
            
        }
        addSubview(baseView)
        addSubview(performanceStackView)
        
        baseView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        baseView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        baseView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        baseView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        performanceStackView.centerYAnchor.constraint(equalTo: baseView.centerYAnchor).isActive = true
        performanceStackView.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
        performanceStackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        performanceStackView.widthAnchor.constraint(equalTo: baseView.widthAnchor, constant: -32).isActive = true
    }
}


