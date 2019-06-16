//
//  OfflineHandler.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-04-04.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import Foundation

extension Array where Element == Categories.Category {
    init(fileName: String) throws {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw Categories.Category.DecodingError.missingFile
        }
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        self = try decoder.decode([Categories.Category].self, from: data)
    }
}


extension Array where Element == Exercises.Exercise {
    init(fileName: String) throws {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw Exercises.DecodingError.missingFile
        }
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let exercises = try decoder.decode([Exercises.Exercise].self, from: data)
        self = exercises
    }
}

class OfflineHandler: NSObject {
    
    static func getExercisesFromBundle(for fileName: String) -> [Exercises.Exercise]? {
        let url = Bundle.main.url(forResource: fileName, withExtension: "json")
        
        do {
            let data = try Data(contentsOf: url!)
            let decoder = JSONDecoder()
            let objects = try decoder.decode([Exercises.Exercise].self, from: data)
            return objects
        } catch {
            print("Could not get the bundled exercises")
        }
        return nil
    }
    
    static func getCategoriesFromBundle(for fileName: String) -> [Categories.Category]? {
        let url = Bundle.main.url(forResource: fileName, withExtension: "json")
        
        do {
            let data = try Data(contentsOf: url!)
            let decoder = JSONDecoder()
            let categories = try decoder.decode([Categories.Category].self, from: data)
            return categories
        } catch {
            print("Could not get the bundled categories")
        }
        return nil
    }

}




