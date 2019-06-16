//
//  SchemaActionCell.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-03-30.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import UIKit


class SchemaActionCell: UITableViewCell {
    
    weak var addRecordVC: AddRecordViewController? {
        didSet {
            if let addRecordVC = addRecordVC {
                isSaveButtonHidden = addRecordVC.isActionCellSaveButtonHidden
                isAddExercisesButtonHidden = addRecordVC.isAddExercisesButtonHidden
                setupView()
            }
            
        }
    }
    var isAddExercisesButtonHidden = false {
        didSet {
            setupView()
        }
    }
    
    var isSaveButtonHidden = false  {
        didSet {
            setupView()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = UIColor.clear
        setupView()
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.layer.backgroundColor = ThemeManager.currentTheme().darkAccentColor.cgColor
        button.setTitle("Cancel", for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 6)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.4
        button.setTitleColor(ThemeManager.currentTheme().textColor, for: .normal)
        button.addTarget(self, action: #selector(AddRecordViewController.cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let addSchemaExerciseButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.layer.backgroundColor = ThemeManager.currentTheme().tintColor.cgColor
        button.setTitle("Add Exercise...", for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 6)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.4
        button.setTitleColor(ThemeManager.currentTheme().textColor, for: .normal)
        button.addTarget(self, action: #selector(AddRecordViewController.addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let saveSchemaExerciseButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.layer.backgroundColor = ThemeManager.currentTheme().backgroundColor.cgColor
        button.setTitle("Save Exercises", for: .normal)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 6)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.4
        button.setTitleColor(ThemeManager.currentTheme().textColor, for: .normal)
        
        button.addTarget(self, action: #selector(AddRecordViewController.saveExercisesTapped), for: .touchUpInside)
        return button
    }()
    
    var containerViewHeightAnchorConstraint: NSLayoutConstraint?
        
    func setupView() {
        
        let padding: CGFloat = 12

        addSubview(containerView)
        
        containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        containerViewHeightAnchorConstraint = containerView.heightAnchor.constraint(equalToConstant: 64)
        containerViewHeightAnchorConstraint?.isActive = true
        
        let buttons: [UIButton] = [cancelButton, addSchemaExerciseButton, saveSchemaExerciseButton]
        
        cancelButton.layer.frame = self.bounds
        cancelButton.layer.cornerRadius = cancelButton.frame.height / 2 - 8
        
        addSchemaExerciseButton.layer.frame = self.bounds
        addSchemaExerciseButton.layer.cornerRadius = addSchemaExerciseButton.frame.height / 2 - 8
        
        saveSchemaExerciseButton.layer.frame = self.bounds
        saveSchemaExerciseButton.layer.cornerRadius = saveSchemaExerciseButton.frame.height / 2 - 8
        
        saveSchemaExerciseButton.alpha = isSaveButtonHidden ? 0 : 1
        addSchemaExerciseButton.alpha = isAddExercisesButtonHidden ? 0 : 1

        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        stackView.heightAnchor.constraint(equalTo: containerView.heightAnchor, constant: -padding).isActive = true
        stackView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
