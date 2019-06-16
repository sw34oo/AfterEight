//
//  NotesLabelCell.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2017-10-12.
//  Copyright © 2017 Niklas Engsoo. All rights reserved.
//

import UIKit

class NotesTextViewCell: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        setupViews()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let notesBaseView = AddRecordBaseView()
    let notesTextView = AddRecordNotesTextView()
    
    func setupViews() {
        addSubview(notesBaseView)
        addSubview(notesTextView)
        
        notesBaseView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        notesBaseView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        notesBaseView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        notesBaseView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        notesBaseView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        notesTextView.topAnchor.constraint(equalTo: notesBaseView.topAnchor).isActive = true
        notesTextView.leadingAnchor.constraint(equalTo: notesBaseView.leadingAnchor).isActive = true
        notesTextView.bottomAnchor.constraint(equalTo: notesBaseView.bottomAnchor).isActive = true
        notesTextView.trailingAnchor.constraint(equalTo: notesBaseView.trailingAnchor).isActive = true
    }
    
    
    
    
    
    
}
