    //
//  RecordFooterCollectionViewCell.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-10-03.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import UIKit

class RecordFooterCollectionViewCell: UICollectionViewCell {
    
    
    var footerData: RecordFooterController? {
        didSet {
            guard let footerData = footerData else { return }
            footerHeaderLabel.text = footerData.title.rawValue
            footerTextLabel.text = footerData.message
            if let date = footerData.date {
                footerDateLabel.text = date.fullDate()
            }
            footerHeaderLabel.backgroundColor = footerData.color
            footerTextLabel.textColor = footerData.color
            
        }
    }
    
    
    let footerBaseView = RecordBaseView()
    
    let footerHeaderLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = ThemeManager.currentTheme().tintColor
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        label.textColor = ThemeManager.currentTheme().invertedTextColor
        label.numberOfLines = 1
        label.textAlignment = .center
        
        if let subheadline = UIFont(name: "SFCompactDisplay-Bold", size: 14) {
            UIFontMetrics(forTextStyle: UIFont.TextStyle.subheadline).scaledFont(for: subheadline)
            label.font = subheadline
        }
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let footerTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = ThemeManager.currentTheme().tintColor
        label.numberOfLines = 1
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let footerDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textColor = ThemeManager.currentTheme().textColor.withAlphaComponent(0.75)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    func setupFooterCell() {
        footerBaseView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(footerBaseView)
        addSubview(footerHeaderLabel)
        addSubview(footerTextLabel)
        addSubview(footerDateLabel)
        
        footerBaseView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        footerBaseView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        footerBaseView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        footerBaseView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        footerHeaderLabel.topAnchor.constraint(equalTo: footerBaseView.topAnchor, constant: 2).isActive = true
        footerHeaderLabel.leadingAnchor.constraint(equalTo: footerBaseView.leadingAnchor).isActive = true
        footerHeaderLabel.heightAnchor.constraint(equalTo: footerBaseView.heightAnchor, multiplier: 3/10).isActive = true
        footerHeaderLabel.trailingAnchor.constraint(equalTo: footerBaseView.trailingAnchor).isActive = true
        
        footerTextLabel.topAnchor.constraint(equalTo: footerHeaderLabel.bottomAnchor, constant: -2).isActive = true
        footerTextLabel.leadingAnchor.constraint(equalTo: footerHeaderLabel.leadingAnchor).isActive = true
        footerTextLabel.heightAnchor.constraint(equalTo: footerBaseView.heightAnchor, multiplier: 5/10).isActive = true
        footerTextLabel.trailingAnchor.constraint(equalTo: footerHeaderLabel.trailingAnchor).isActive = true
        
        footerDateLabel.leadingAnchor.constraint(equalTo: footerBaseView.leadingAnchor).isActive = true
        footerDateLabel.topAnchor.constraint(equalTo: footerTextLabel.bottomAnchor, constant: -2).isActive = true
        footerDateLabel.trailingAnchor.constraint(equalTo: footerBaseView.trailingAnchor).isActive = true
        footerDateLabel.heightAnchor.constraint(equalTo: footerBaseView.heightAnchor, multiplier: 2/10).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFooterCell()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




