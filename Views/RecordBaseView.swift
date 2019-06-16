//
//  RecordBaseView.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-09-26.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import UIKit

class RecordBaseView: UIView {
    
    let mainView: UIView = {
        let view = UIView()
        view.layer.backgroundColor = ThemeManager.currentTheme().backgroundColor.cgColor
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.masksToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = ThemeManager.currentTheme().whiteColor.cgColor
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.layer.cornerRadius = 22
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupRecordBaseView()
    }
    
    
    
    func setupRecordBaseView() {
     
        addSubview(mainView)
        mainView.addSubview(headerView)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
