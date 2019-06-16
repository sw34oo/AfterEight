//
//  DefaultsHeaderView.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-04-28.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import UIKit

import UIKit

class DefaultsHeaderLabel: UILabel {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeaderView()
    }
  
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = ThemeManager.currentTheme().textColor
        label.font = UIFont.systemFont(ofSize: 28, weight: .black)
        label.text = "Defaults"
        label.textAlignment = .center
        label.alpha = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    func setupHeaderView() {
        addSubview(headerLabel)
        headerLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        headerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        headerLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 9/10).isActive = true

        
    }
    
}

