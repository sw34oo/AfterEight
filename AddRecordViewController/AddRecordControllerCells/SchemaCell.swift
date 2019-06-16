//
//  SchemaCell.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-03-18.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import UIKit

class SchemaCell: UITableViewCell {
        
    var schemaRecord: SchemaRecord? {
        didSet {
            if let schemaRecord = schemaRecord {
                setupSchemaRecord(schemaRecord)
            }
            
        }
    }
    
    fileprivate func setupSchemaRecord(_ schemaRecord: SchemaRecord) {
        
        exerciseLabel.text = schemaRecord.exerciseName
        repLabel.text = String(schemaRecord.reps)
        setLabel.text = String(schemaRecord.sets)
        
        var weight: String = ""
        
        if let usersWeightUnit = UserDefaults.standard.string(forKey: weightUnitKey) {
            if usersWeightUnit == "kg" {
                weight = String(Int(schemaRecord.weight))
            } else if usersWeightUnit == "lb" {
                let pounds = (schemaRecord.weight / poundsMultiplier)
                weight = String(lround(pounds))
            }
        }
        weightLabel.text = weight
    }
    
    let width: CGFloat = 24
        
    let mainView = AddRecordBaseView()
    
    let exerciseLabel: UILabel = {
        let label = UILabel()
        if let font = UIFont(name: "SFCompactDisplay-Medium", size: 16) {
            label.font = UIFontMetrics.default.scaledFont(for: font)
        }
        label.textColor = ThemeManager.currentTheme().textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let repLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        label.textColor = ThemeManager.currentTheme().invertedTextColor
        label.backgroundColor = ThemeManager.currentTheme().textColor.withAlphaComponent(0.7)
        if let font = UIFont(name: "SFCompactDisplay-Bold", size: 16) {
            label.font = UIFontMetrics.default.scaledFont(for: font)
        }
        label.textAlignment = .center
        label.layer.masksToBounds = true
        return label
    }()
    
    let setLabel: UILabel = {
        let label = UILabel()
        label.textColor = ThemeManager.currentTheme().invertedTextColor
        label.backgroundColor = ThemeManager.currentTheme().textColor.withAlphaComponent(0.7)
        if let font = UIFont(name: "SFCompactDisplay-Bold", size: 16) {
            label.font = UIFontMetrics.default.scaledFont(for: font)
        }
        label.textAlignment = .center
        label.layer.masksToBounds = true
        return label
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        label.textColor = ThemeManager.currentTheme().invertedTextColor
        label.backgroundColor = ThemeManager.currentTheme().textColor.withAlphaComponent(0.7)
        if let font = UIFont(name: "SFCompactDisplay-Bold", size: 16) {
            label.font = UIFontMetrics.default.scaledFont(for: font)
        }
        label.textAlignment = .center
        label.layer.masksToBounds = true
        return label
    }()
    
    
    
    let strokeView: UIView = {
        let stroke = UIView()
        stroke.backgroundColor = ThemeManager.currentTheme().darkAccentColor
        stroke.layer.cornerRadius = 1
        stroke.layer.masksToBounds = true
        stroke.translatesAutoresizingMaskIntoConstraints = false
        return stroke
    }()
    
    
    private func setupView() {
        
        let weightLabels = [repLabel, setLabel, weightLabel]
        
        let height: CGFloat = 28
        let padding: CGFloat = 8
        let numViews = CGFloat(weightLabels.count)
        
        let containerWidth: CGFloat = ((2 * height) + (1.5 * height)) + (numViews + 1) * padding
        
        weightLabels.forEach { (label) in
            label.layer.cornerRadius = height / 2
        }
        
        let stackView = UIStackView(arrangedSubviews: weightLabels)
        
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.spacing = padding
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainView)
        addSubview(exerciseLabel)
        addSubview(strokeView)
        addSubview(stackView)
        mainView.layer.cornerRadius = Constants.halfCornerRadius
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        mainView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        mainView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        mainView.heightAnchor.constraint(equalTo: containerView.heightAnchor, constant: -4).isActive = true
        mainView.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -32).isActive = true
//        mainView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        strokeView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -8).isActive = true
        strokeView.leadingAnchor.constraint(equalTo: exerciseLabel.leadingAnchor).isActive = true
        strokeView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        strokeView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 5/10).isActive = true
        
        exerciseLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor, constant: -4).isActive = true
        exerciseLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16).isActive = true
        exerciseLabel.trailingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        
        repLabel.widthAnchor.constraint(equalToConstant: height).isActive = true
        setLabel.widthAnchor.constraint(equalToConstant: height).isActive = true
        weightLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: height * 1.5).isActive = true
        
        stackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8).isActive = true
        stackView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: containerWidth).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: height + 2 * padding).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
