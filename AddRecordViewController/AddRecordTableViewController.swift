//
//  AddRecordTableViewController.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2017-12-03.
//  Copyright © 2017 Niklas Engsoo. All rights reserved.
//

import UIKit

extension AddRecordViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SchemaButtonsCell.self, forCellReuseIdentifier: SchemaButtonsCell.identifier)
        tableView.register(SchemaCell.self, forCellReuseIdentifier: SchemaCell.identifier)
        tableView.register(SchemaActionCell.self, forCellReuseIdentifier: SchemaActionCell.identifier)
        schemaCellData = []
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return schemaCellData.count
        } else if section == 2 {
            return schemaActionCell.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let schemaButtonCell = tableView.dequeueReusableCell(withIdentifier: SchemaButtonsCell.identifier, for: indexPath) as! SchemaButtonsCell
            schemaButtonCell.addRecordVC = self
            return schemaButtonCell
            
        } else if indexPath.section == 1 {
            if let schemaCell = tableView.dequeueReusableCell(withIdentifier: SchemaCell.identifier, for: indexPath) as? SchemaCell {
                schemaCell.schemaRecord = schemaCellData[indexPath.row]
                return schemaCell
            }
        } else if indexPath.section == 2 {
            if let schemaActionCell = tableView.dequeueReusableCell(withIdentifier: SchemaActionCell.identifier, for: indexPath) as? SchemaActionCell {
                schemaActionCell.addRecordVC = self
                return schemaActionCell
            }
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 52
        } else {
            return UITableView.automaticDimension
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            print("Selected schema at row: \(selectedSchemaIndex)")
            
        } else if indexPath.section == 1 {
            let cell = tableView.cellForRow(at: indexPath) as! SchemaCell
            schemaRecord = cell.schemaRecord
            editSchema()
            setupCellData()
        }
        tableView.deselectRow(at: indexPath as IndexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1 {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if editingStyle == .delete {
                let schemaRecord = schemaCellData[indexPath.row]
                deleteSchemaRecord(schemaRecord: schemaRecord, indexPath: indexPath)
            }
        }
    }
    
    func deleteSchemaRecord(schemaRecord: SchemaRecord, indexPath: IndexPath) {
        schemaCellData.remove(at: indexPath.row)
        try? schemaRecord.saveSchemaRecordToDisk(schemaRecord: schemaCellData)
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: .left)
        tableView.reloadData()
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        tableView.endUpdates()
    }
    
    
    func getSchemaRecords(for schemaId: Int) {
        let storedSchemaRecords = SchemaRecords.getSchemaRecordsFromDisk(pathComponent: schemaRecordPath, schemaId: schemaId)
        
        if storedSchemaRecords.count < 1 {
            isActionCellSaveButtonHidden = true
        } else {
            isActionCellSaveButtonHidden = false
        }
        isAddExercisesButtonHidden = false
        insertSchemaRecordRow(storedSchemaRecords)
        insertActionCell()
    }
    
    
    
    func removeSchemaRows() {
        if schemaCellData.count > 0 {
            for _ in schemaCellData {
                let index = schemaCellData.count - 1
                schemaCellData.remove(at: index)
                let indexPath = IndexPath(row: index, section: 1)
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: [indexPath], with: .none)
                self.tableView.endUpdates()
            }
        }
    }
    
    func insertSchemaRecordRow(_ schemaRecords: [SchemaRecord]) {
        hideAddRecordCells()
        removeSchemaRows()
        let index = 0
        for record in schemaRecords.reversed() {
            schemaCellData.insert(record, at: index)
            let indexPath = IndexPath(row: index, section: 1)
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [indexPath], with: .bottom)
            self.tableView.endUpdates()
        }
        insertActionCell()
        
    }
    
    func hideAddRecordCells() {
        UIView.animate(withDuration: 0.5) {
            self.addRecordScrollView.alpha = 0
        }
    }

    func showAddRecordCells() {
        UIView.animate(withDuration: 0.5) {
            self.dateCell.isHidden = self.isSchemaRecord ? true : false
            self.dateCell.alpha = self.isSchemaRecord ? 0 : 1
            self.addRecordScrollView.alpha = 1
        }
    }
    
    func hideAllCellsButNotesTextCell(_ bool: Bool, alpha: CGFloat) {
        UIView.animate(withDuration: 0.7) {
            self.dateCell.alpha =  alpha
            self.categoryCell.alpha = alpha
            self.exerciseTextCell.alpha = alpha
            self.ratingCell.alpha = alpha
            
            self.dateCell.isHidden =  bool
            self.categoryCell.isHidden = bool
            self.exerciseTextCell.isHidden = bool
            self.ratingCell.isHidden = bool
        }
    }
    
    func insertActionCell() {
        if schemaActionCell.count == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: SchemaActionCell.identifier) as? SchemaActionCell {
                schemaActionCell.insert(cell, at: 0)
                let schemaActionIndexPath = IndexPath(row: 0, section: 2)
                tableView.beginUpdates()
                self.tableView.insertRows(at: [schemaActionIndexPath], with: .bottom)
                tableView.endUpdates()
            }
        } else {
            tableView.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .right)
        }
    }
    
    func removeActionCell() {
        if schemaActionCell.count > 0 {
            schemaActionCell.removeAll()
            let schemaActionIndexPath = IndexPath(row: 0, section: 2)
            tableView.beginUpdates()
            self.tableView.deleteRows(at: [schemaActionIndexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    @objc func cancelButtonTapped(_ button: UIButton) {
        isSchemaRecord = false
        record = nil
        schemaRecord = nil
        removeActionCell()
        removeSchemaRows()
        showAddRecordCells()
        setupCellData()
    }
    
    @objc func addButtonTapped() {
        record = nil
        schemaRecord = nil
        isSchemaRecord = true
        isAddExercisesButtonHidden = true
        isActionCellSaveButtonHidden = true
        removeSchemaRows()
        insertActionCell()
        showAddRecordCells()
        setupCellData()
    }
    
    fileprivate func editSchema() {
        isSchemaRecord = true
        record = nil
        isAddExercisesButtonHidden = true
        isActionCellSaveButtonHidden = true
        removeSchemaRows()
        insertActionCell()
        showAddRecordCells()
        setupCellData()
    }
    
    @objc func saveExercisesTapped() {
        for schemaRecord in schemaCellData {
            let newRecord = Record(context: DatabaseController.context)
            newRecord.date = Date() as NSDate
            newRecord.categoryName = schemaRecord.categoryName
            newRecord.exerciseName = schemaRecord.exerciseName
            newRecord.reps = Int16(schemaRecord.reps)
            newRecord.sets = Int16(schemaRecord.sets)
            newRecord.weight = schemaRecord.weight
            
            if schemaRecord.notes == notes {
                newRecord.notes = ""
            } else {
                newRecord.notes = schemaRecord.notes
            }
            newRecord.rating = Int16(schemaRecord.rating)
            DatabaseController.saveContext()
        }
        isAddExercisesButtonHidden = false
        isActionCellSaveButtonHidden = false
        dismissViewController()
    }
    
    
}



