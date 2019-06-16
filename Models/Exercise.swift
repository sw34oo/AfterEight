//
//  Exercise.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-07-30.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import Foundation

struct Exercises: Codable {
    
    let exercises: [Exercise]
    
    init(exercises: [Exercise]) {
        self.exercises = exercises
    }
    
    enum DecodingError: Error {
        case missingFile
    }
    
    enum CodingKeys: String, CodingKey {
        case exercises = "results"
    }
    
    struct Exercise: Codable, Equatable {
        let id: Int
        let name: String
        let category: Int
        let description: String
        let muscles: [Int]
        let musclesSecondary: [Int]
        let equipment: [Int]
        
        enum DecodingError: Error {
            case missingFile
        }
        
        enum CodingKeys: String, CodingKey {
            case id, name, category, description, muscles, musclesSecondary, equipment
        }
    }
    
    func saveToDisk() throws {
        
        let directoryURL = FileManager.documentDirectoryURL.appendingPathComponent(storedExercisePath)
        
        try? FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let data = try encoder.encode(exercises)
            try data.write(to: directoryURL.appendingPathExtension("json"), options: .atomic)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func getExercisesFromDisk(pathComponent: String) -> [Exercises.Exercise] {
        let url = FileManager.documentDirectoryURL.appendingPathComponent(pathComponent).appendingPathExtension("json")
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: url, options: [])
            let exercises = try decoder.decode([Exercises.Exercise].self, from: data)
            return exercises
            
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
 
    func filteredExercises(by category: (id: Int, index: Int)) -> [Exercises.Exercise] {
        return exercises.filter { $0.category == category.id }
    }
    
    func getDocumentsURL() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return url
    }
    
    
    
    
}


