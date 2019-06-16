//
//  RecordsFetchrequestControllerDelegate.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2017-12-02.
//  Copyright © 2017 Niklas Engsoo. All rights reserved.
//

import UIKit
import CoreData

extension RecordsViewController {
    
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                performFetch()
            }
            break;
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                performFetch()
            }
            break;
        case .update:
            if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath) as? RecordsCell {
                configure(cell, at: indexPath)
            }
            break;
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }

            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: UITableView.RowAnimation.automatic)
            }
        @unknown default:
            print("Cound not handle change")
        }
    }

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
