//
//  extension RecordVC TableViewController.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-01-17.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import UIKit

extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = recordFetchRequestController.sections?[section].numberOfObjects {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recordsCell = tableView.dequeueReusableCell(withIdentifier: RecordsCell.identifier, for: indexPath) as! RecordsCell
        configure(recordsCell, at: indexPath)
        return recordsCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let record = recordFetchRequestController.object(at: indexPath)
        showDetailForRecord(record: record)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: RecordHeaderCell.identifier) as! RecordHeaderCell
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(88)
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(44)
    }

    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete") { (contextualAction, view, actionPerformed: (Bool) -> Void) in
            let record = self.recordFetchRequestController.object(at: indexPath)            
            self.deleteRecordAction(on: self, record: record, indexPath: indexPath)
            actionPerformed(true)
        }
        delete.backgroundColor = UIColor.red
        delete.image = UIImage(named: "trash")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, actionPerformed:
            (Bool) -> Void) in
            
            let record = self.recordFetchRequestController.object(at: indexPath)
            self.editRecord(record: record)
            actionPerformed(true)   
        }
        edit.backgroundColor = ThemeManager.currentTheme().tintColor
        edit.image = UIImage(named: "edit")
        return UISwipeActionsConfiguration(actions: [edit])
    }

    
}
