//
//  RecordFooterController.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-05-21.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import Foundation
import UIKit

enum Title: String {
    case firstTime = "Great! Variation is... Just Great!!"
    case keepItUp = "Yeah! Keep it up, you're doing it just right!"
    case aWhileAgo = "It's been a while since you did any"
    case increaseWeight = "Time to increase the weight?"
    case totalWeight = "Total weight lifted:"
}


struct RecordFooterController {
    
    let title: Title
    let message: String
    let date: Date?
    let color: UIColor
    
    static func setFooterData() -> [RecordFooterController] {
        
        var footerObjects = [RecordFooterController]()
        let storedRecords = Record.allRecords()
        
        let firstTimeExercises = firstTimeRecords(storedRecords)
        for footerInfo in firstTimeExercises {
            let firstTimeFooterInfo = RecordFooterController(title: .firstTime, message: footerInfo.message, date: footerInfo.date, color: footerInfo.color)
            footerObjects.append(firstTimeFooterInfo)
        }
        
        // Keep up what you're doing exercises
        let greatPerformances = greatPerformance(storedRecords)
        for footerInfo in greatPerformances {
            let greatPerf = RecordFooterController(title: footerInfo.title, message: footerInfo.message, date: footerInfo.date, color: footerInfo.color)
            footerObjects.append(greatPerf)
        }

        // Records you should probably add weight to
        let increaseRecords = increaseWeight()
        for footerInfo in increaseRecords {
            let increase = RecordFooterController(title: .increaseWeight, message: footerInfo.message, date: footerInfo.date, color: footerInfo.color)
            footerObjects.append(increase)
        }
        
        //Do these exercises again!
        let oldExercises = timeForTheseRecordsAgain(storedRecords)
        for footerInfo in oldExercises {
            let tryAgain = RecordFooterController(title: .aWhileAgo, message: footerInfo.message, date: footerInfo.date, color: footerInfo.color)
            footerObjects.append(tryAgain)
        }
        
        // Get total weight
        let weight = totalWeight(records: storedRecords )
        footerObjects.append(weight)
        return footerObjects
    }
    
    fileprivate static func firstTimeRecords(_ allrecords: [Record]) -> [RecordFooterController] {
        let now = Date()
        let aWeekAgo = Calendar.current.date(byAdding: .day, value: -7, to: now)!
        var doItAgainFooterInfo = [RecordFooterController]()
        
        let moreThanWeekOldRecords = allrecords.filter({ ($0.date! as Date) > aWeekAgo} )
        let weekOldRecords = allrecords.filter({ ($0.date! as Date) < aWeekAgo} )
        var firstTimeRecordDict: Dictionary = [String: Date]()
        
        var moreThanWeekOldNames = Set<String>()
        var weekOldExerciseName = Set<String>()
        
        for oldRecord in allrecords {
            moreThanWeekOldNames.insert(oldRecord.exerciseName!)
        }
        for recentRecord in weekOldRecords {
            weekOldExerciseName.insert(recentRecord.exerciseName!)
        }
        let filteredSet = weekOldExerciseName.symmetricDifference(moreThanWeekOldNames)

        for record in moreThanWeekOldRecords {
            for name in filteredSet {
                if record.exerciseName! != name {
                    firstTimeRecordDict[name] = record.date! as Date
                }
            }
        }
        for (exercise, date) in firstTimeRecordDict {
            let firstTimeExercise = RecordFooterController(title: .firstTime, message: exercise, date: date, color: ThemeManager.currentTheme().tintColor)
            doItAgainFooterInfo.append(firstTimeExercise)
        }
        return doItAgainFooterInfo
        
    }
    
    
    fileprivate static func greatPerformance(_ allrecords: [Record]) -> [RecordFooterController] {
        
        let now = Date()
        let lastMonth = Calendar.current.date(byAdding: .month, value: -1, to: now)!
        let lastmonthsRecords = allrecords.filter({ ($0.date! as Date) > lastMonth } )
        
        var greatRecordInfos = [RecordFooterController]()
        var greatDict: Dictionary = Dictionary(grouping: lastmonthsRecords) { (element) -> String in
            return element.exerciseName!
        }
        
        let keys = greatDict.keys.sorted()
        keys.forEach { (key) in
            if greatDict[key]!.count > 2 {
                if let exercises = greatDict[key] {
                    let sortedExercises = exercises.sorted(by: ({ ($0.date! as Date) < ($1.date! as Date) }))
                    let count = sortedExercises.count
                    if sortedExercises[0].weight < sortedExercises[1].weight && sortedExercises[count-2].weight < sortedExercises[count-1].weight {
                        let greatPerformance = RecordFooterController(title: .keepItUp, message: sortedExercises[0].exerciseName!, date: sortedExercises[count-1].date! as Date, color: ThemeManager.currentTheme().tintColor)
                        greatRecordInfos.append(greatPerformance)
                    }
                }
            }
        }
        return greatRecordInfos
    }

    
    fileprivate static func timeForTheseRecordsAgain(_ allrecords: [Record]) -> [RecordFooterController] {
        let now = Date()
        let amonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: now)!
        var doItAgainFooterInfo = [RecordFooterController]()
        
        let oldRecords = allrecords.filter({ ($0.date! as Date) < amonthAgo} )
        let monthOldRecords = allrecords.filter({ ($0.date! as Date) > amonthAgo} )
        var oldRecordDict: Dictionary = [String: Date]()
        
        var oldExerciseNames = Set<String>()
        var recentExerciseName = Set<String>()
        
        for oldRecord in oldRecords {
            oldExerciseNames.insert(oldRecord.exerciseName!)
        }
        for recentRecord in monthOldRecords {
            recentExerciseName.insert(recentRecord.exerciseName!)
        }
        let filteredSet = oldExerciseNames.subtracting(recentExerciseName)

        for record in allrecords {
            for name in filteredSet {
                if record.exerciseName! == name {
                    oldRecordDict[name] = record.date! as Date
                }
            }
        }
        for (exercise, date) in  oldRecordDict {
            let oldExercise = RecordFooterController(title: .aWhileAgo, message: exercise, date: date, color: ThemeManager.currentTheme().accentColor)
            doItAgainFooterInfo.append(oldExercise)
        }
        return doItAgainFooterInfo
        
    }
    
    fileprivate static func increaseWeight() -> [RecordFooterController] {
        
        let yellowColor = UIColor.rgb(red: 255, green: 155, blue: 0, alpha: 1)
        
        let storedRecords = Record.allRecords()
        let now = Date()
        let lastMonth = Calendar.current.date(byAdding: .month, value: -1, to: now)!
        let lastmonthsRecords = storedRecords.filter({ ($0.date! as Date) > lastMonth } )
        var increaseRecords = [RecordFooterController]()
        
        var increaseDict: Dictionary = Dictionary(grouping: lastmonthsRecords) { (element) -> String in
            return element.exerciseName!
        }
        
        let keys = increaseDict.keys.sorted()
        keys.forEach { (key) in
            if increaseDict[key]!.count > 2 {
                if let exercises = increaseDict[key] {
                    let count = exercises.count
                    if exercises[0].weight == exercises[1].weight && exercises[count-1].weight == exercises[count-2].weight {
                        let increaseWeight = RecordFooterController(title: .increaseWeight, message: exercises[count-1].exerciseName!, date: exercises[count-1].date! as Date, color: yellowColor)
                            increaseRecords.append(increaseWeight)
                    }
                }
            }
        }
        return increaseRecords
    }
    
    
    fileprivate static func totalWeight(records: [Record]) -> RecordFooterController {
        var totalWeight: Double = 0
        let weightUnitString = UserDefaults.standard.string(forKey: weightUnitKey)
        
        for record in records {
            totalWeight += record.weight
        }
        
        if let weightUnit = UserDefaults.standard.string(forKey: weightUnitKey) {
            if weightUnit == "lb" {
                totalWeight /= poundsMultiplier
            }
        }
        let weight = String(lround(totalWeight)) + " " + weightUnitString!
        let footerTotalWeight = RecordFooterController(title: .totalWeight, message: weight, date: Date(), color: ThemeManager.currentTheme().textColor)
        
        return footerTotalWeight
    }
    
    
}
