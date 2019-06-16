//
//  RecordHeaderCell.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2017-12-03.
//  Copyright © 2017 Niklas Engsoo. All rights reserved.
//

import UIKit

class RecordHeaderCell: UITableViewHeaderFooterView {
    
    weak var recordsVC: RecordsViewController? {
        didSet {
            if let recordsVC = recordsVC {
                recordsVC.recordSegmentSortControl = recordSegmentSortControl
            }
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
        self.backgroundView = UIView()
        self.backgroundView?.backgroundColor = UIColor.clear
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    let recordSegmentSortControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Date  ▼", "Exercise  ▼"])
        sc.layer.borderWidth = 1
        sc.layer.cornerRadius = 0
        sc.layer.borderColor = UIColor.black.cgColor
        sc.layer.backgroundColor = ThemeManager.currentTheme().backgroundColor.cgColor
        var sorterFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
        if let font = UIFont(name: "SFCompactDisplay-Bold", size: 16) {
            sorterFont = font
        }
        sc.layer.masksToBounds = true

        let titleAttributes: [NSAttributedString.Key:Any] = [NSAttributedString.Key.font : sorterFont, NSAttributedString.Key.foregroundColor : ThemeManager.currentTheme().invertedTextColor]
        sc.setTitleTextAttributes(titleAttributes, for: .normal)
        sc.setTitleTextAttributes(titleAttributes, for: .selected)
        sc.isMomentary = true
        sc.addTarget(self, action: #selector(RecordsViewController.sortRecords), for: .valueChanged)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    func setupView() {
        addSubview(recordSegmentSortControl)
         
        recordSegmentSortControl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        recordSegmentSortControl.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        recordSegmentSortControl.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor).isActive = true
        recordSegmentSortControl.heightAnchor.constraint(equalToConstant: 40).isActive = true

    }

}
