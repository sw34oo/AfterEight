//
//  SchemaButtonsCell.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-03-24.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import UIKit

class SchemaButtonsCell: UITableViewCell {
    
    var addRecordVC: AddRecordViewController?
    
    var selectedIndex = 0 {
        didSet {
            if let addRecordVC = addRecordVC {
                addRecordVC.selectedSchemaIndex = self.selectedIndex
            }
            setupView()
        }
    }
    
    var buttons: [UIButton] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = UIColor.clear
        setupView()        
    }

    
    func setupView() {
        
        buttons.forEach({ (button) in
            button.removeFromSuperview()
        })
        buttons.removeAll()
        
        let padding: CGFloat = 12
        let width: CGFloat = UIScreen.main.bounds.width - padding * 2
        let height: CGFloat = width / 7
        
        for numButton in 0...6 {
            
            let button = UIButton()
            let schemaRecords = SchemaRecords.getSchemaRecordsFromDisk(pathComponent: schemaRecordPath, schemaId: numButton)
            
            if schemaRecords.count == 0 {
                button.setTitle("\(numButton + 1)", for: .normal)
                button.layer.backgroundColor = ThemeManager.currentTheme().backgroundColor.cgColor
                button.setTitleColor(ThemeManager.currentTheme().textColor.withAlphaComponent(0.6), for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: 14, weight: .heavy)
                button.layer.borderColor = ThemeManager.currentTheme().textColor.withAlphaComponent(0.4).cgColor
                buttons.append(button)
            } else {
                let title = setSchemaButtonText(schemaRecords)
                button.setTitle(title, for: .normal)
                button.layer.backgroundColor = ThemeManager.currentTheme().tintColor.cgColor
                button.setTitleColor(ThemeManager.currentTheme().invertedTextColor.withAlphaComponent(0.8), for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: 13, weight: .heavy)
                button.layer.borderColor = ThemeManager.currentTheme().textColor.withAlphaComponent(0.55).cgColor
                buttons.append(button)
            }
            button.layer.cornerRadius = (height - padding) / 2
            button.layer.shadowColor = UIColor.black.cgColor
            button.layer.shadowOffset = CGSize(width: 3, height: 6)
            button.layer.shadowRadius = 3
            button.layer.shadowOpacity = 0.5
            button.layer.borderWidth = 6
            button.setTitleColor(ThemeManager.currentTheme().accentColor, for: .selected)
            button.addTarget(self, action: #selector(schemaButtonTapped(_:)), for: .touchUpInside)
        }
        
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = padding
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        stackView.widthAnchor.constraint(equalToConstant: width  + padding).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: height + padding).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

    }
    
    @objc func schemaButtonTapped(_ button: UIButton) {
        for (index, selectedButton) in buttons.enumerated() {
            if button == selectedButton {
                selectedIndex = index
            }
        }
    }
    
    func setSchemaButtonText(_ schemas: [SchemaRecord]) -> String {
        var title: String = ""
        var categoryDictionary: [String: Int] = [:]
        var topCategories = [String]()
        for schema in schemas {
            let categoryName = schema.categoryName
            if let count = categoryDictionary[categoryName] {
                categoryDictionary[categoryName] = count + 1
            } else {
                categoryDictionary[categoryName] = 1
            }
        }
        let topCategory = categoryDictionary.values.max()
        for (category, _) in categoryDictionary {
            if categoryDictionary[category] == topCategory {
                topCategories.append(category)
            }
        }
        if let category = topCategories.first {
            title = String(category.prefix(2))
        }
        return title.uppercased()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
