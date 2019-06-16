//
//  Extension RecordDetailViewController.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-01-22.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import UIKit



extension RecordDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 && indexPath.row == 0 {
            if let detailCell = tableView.dequeueReusableCell(withIdentifier: RecordTableViewDetailCell.identifier, for: indexPath) as? RecordTableViewDetailCell {
                if let records = records {
                    detailCell.records = records
                }
                let delay = DispatchTime.now() + .milliseconds(250)
                DispatchQueue.main.asyncAfter(deadline: delay) {
                    detailCell.detailCollectionView.scrollToItem(at: IndexPath(item: self.selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
                }
                return detailCell
            }

            
        } else if indexPath.section == 1 && indexPath.row == 0 {
            let graphCell = tableView.dequeueReusableCell(withIdentifier: RecordTableViewGraphCell.identifier, for: indexPath) as! RecordTableViewGraphCell
            if let records = records {
                graphCell.records = records
            }
            return graphCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return tableView.frame.height * 5.5/10
        } else if indexPath.section == 1 {
            return tableView.frame.height * 4/10
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RecordTableViewDetailCell {
            let indexPath = IndexPath(item: 1, section: 0)
            cell.detailCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            cell.detailCollectionView.reloadData()
        }
    }
    
    
    
    
    
}
