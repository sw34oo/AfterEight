//
//  SchemaRecordModel.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-03-31.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import Foundation


struct SchemaRecord: Codable {
    
    public var schemaId: Int
    public var date: Date
    public var categoryName: String
    public var exerciseName: String
    public var reps: Int
    public var sets: Int
    public var weight: Double
    public var notes: String
    public var rating: Int


    func saveSchemaRecordToDisk(schemaRecord: [SchemaRecord]) throws {

        let directoryURL = FileManager.documentDirectoryURL.appendingPathComponent(schemaRecordPath).appendingPathComponent("\(schemaId)")
        
        try? FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let data = try encoder.encode(schemaRecord)
            try data.write(to: directoryURL.appendingPathExtension("txt"), options: .atomic)
        } catch {
            print(error.localizedDescription)
        }
    }
}



struct SchemaRecords: Codable {
    let schemaRecords: [SchemaRecord]
    
    static func getSchemaRecordsFromDisk(pathComponent: String, schemaId: Int) -> [SchemaRecord] {
        
        let url = FileManager.documentDirectoryURL.appendingPathComponent(pathComponent).appendingPathComponent("\(schemaId)").appendingPathExtension("txt")
        
        do {
            let decoder = JSONDecoder()
            let data = try Data(contentsOf: url, options: [])
            let records = try decoder.decode([SchemaRecord].self, from: data)
            return records
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    
    
    static func removeSchemaRecordsFromDisk(pathComponent: String) {
        let dir = FileManager.documentDirectoryURL.appendingPathComponent(pathComponent)
        let removeFile = dir.appendingPathExtension("txt")
            do {
                try FileManager.default.removeItem(at: removeFile)
            } catch {
                print("Can't remove file")
            }
        }
    
    
}







