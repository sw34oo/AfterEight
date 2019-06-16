//
//  Record+CoreDataProperties.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2017-12-12.
//  Copyright © 2017 Niklas Engsoo. All rights reserved.
//
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }
    
    

    @NSManaged public var categoryName: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var exerciseName: String?
    @NSManaged public var notes: String?
    @NSManaged public var rating: Int16
    @NSManaged public var reps: Int16
    @NSManaged public var sets: Int16
    @NSManaged public var weight: Double
    
    
    func getLastExercise(_ exercise: String) -> Record? {
        var records = [Record]()
        let fetchRequest: NSFetchRequest<Record> = Record.fetchRequest()
        
        do {
            let objects = try DatabaseController.context.fetch(fetchRequest)
            for record in objects {
                if exercise == record.exerciseName {
                    records.append(record)
                }
            }
        } catch {
            print("Error fetching Record", error.localizedDescription)
        }
        return records.last
    }
    
    class func allRecords() -> [Record] {
        var records = [Record]()
        
        let fetchRequest: NSFetchRequest<Record> = Record.fetchRequest()
        do {
            records = try DatabaseController.context.fetch(fetchRequest)
        } catch {
            print("Error fetching Record", error.localizedDescription)
        }
        return records
    }
    
    

}
