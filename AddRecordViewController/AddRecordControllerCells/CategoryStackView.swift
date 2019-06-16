//
//  CategoryTableViewCell.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2017-11-07.
//  Copyright © 2017 Niklas Engsoo. All rights reserved.
//

import UIKit

protocol CategorySelectionDelegate {
    func categoryButtonPressed(categoryName: String, categoryId: Int)
}

class CategoryStackView: UIView  {
    
    var categories: [Categories.Category]? {
        didSet {
            setupView()
        }
    }
    
    var categorySelectionDelegate: CategorySelectionDelegate?
    
    var buttons = [UIButton]()
    var buttonViews = [UIView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        categories = Categories.getCategoriesFromDisk(pathComponent: storedCategoryPath)
        setupView()
    }

    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let categoryScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    @objc func categoryButtonPressed(_ sender: UIButton) {
        for (index, button) in buttons.enumerated() {
            if button == sender {
                button.isSelected = true
                let imageView = buttonViews[index] as! AddCategoryView
                imageView.strokeView.backgroundColor = ThemeManager.currentTheme().textColor
            } else {
                button.isSelected = false
                let imageView = buttonViews[index] as! AddCategoryView
                imageView.strokeView.backgroundColor = ThemeManager.currentTheme().tintColor
            }
        }
        categoryScrollView.scrollRectToVisible(sender.frame, animated: true)
        categorySelectionDelegate?.categoryButtonPressed(categoryName: sender.currentTitle!, categoryId: sender.tag)
    }
    
    func setupView() {
        guard let categories = categories else { return }
        
        buttons.forEach { (button) in
            button.removeFromSuperview()
        }
        buttons.removeAll()
        buttonViews.forEach { (view) in
            view.removeFromSuperview()
        }
        buttonViews.removeAll()
        
        for category in categories {
            let button = AddCategoryButton()
            let buttonImageView = AddCategoryView()
            button.setTitle(category.name, for: .normal)
            button.tag = category.id
            button.addTarget(self, action: #selector(categoryButtonPressed(_:)), for: .touchUpInside)
            buttonViews.append(buttonImageView)
            buttons.append(button)
        }
        
        
        let categoryStackView = UIStackView(arrangedSubviews: buttonViews)
        categoryStackView.axis = .horizontal
        categoryStackView.spacing = 8
        categoryStackView.alignment = .fill
        categoryStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let categoryButtonStackView = UIStackView(arrangedSubviews: buttons)
        categoryButtonStackView.axis = .horizontal
        categoryButtonStackView.spacing = 8
        categoryButtonStackView.distribution = .equalSpacing
        categoryButtonStackView.alignment = .fill
        categoryButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(categoryScrollView)
        categoryScrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        categoryScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        categoryScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        categoryScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        categoryScrollView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        categoryScrollView.addSubview(categoryStackView)
        categoryStackView.topAnchor.constraint(equalTo: categoryScrollView.topAnchor).isActive = true
        categoryStackView.leadingAnchor.constraint(equalTo: categoryScrollView.leadingAnchor).isActive = true
        categoryStackView.bottomAnchor.constraint(equalTo: categoryScrollView.bottomAnchor).isActive = true
        categoryStackView.trailingAnchor.constraint(equalTo: categoryScrollView.trailingAnchor).isActive = true
        categoryStackView.heightAnchor.constraint(equalTo: categoryScrollView.heightAnchor).isActive = true
        
        categoryScrollView.addSubview(categoryButtonStackView)
        categoryButtonStackView.topAnchor.constraint(equalTo: categoryScrollView.topAnchor).isActive = true
        categoryButtonStackView.leadingAnchor.constraint(equalTo: categoryScrollView.leadingAnchor).isActive = true
        categoryButtonStackView.bottomAnchor.constraint(equalTo: categoryScrollView.bottomAnchor).isActive = true
        categoryButtonStackView.trailingAnchor.constraint(equalTo: categoryScrollView.trailingAnchor).isActive = true
        categoryButtonStackView.heightAnchor.constraint(equalTo: categoryScrollView.heightAnchor).isActive = true
        
    }
}
    
    

    
    

