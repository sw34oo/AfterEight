//
//  Category.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-07-30.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import Foundation

class Categories: Codable {

    public var categories: [Category]

    
    func saveToDisk() throws {
        
        let directoryURL = FileManager.documentDirectoryURL.appendingPathComponent(storedCategoryPath)
        
        try? FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let data = try encoder.encode(categories)
            try data.write(to: directoryURL.appendingPathExtension("json"), options: .atomic)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func getCategoriesFromDisk(pathComponent: String) -> [Categories.Category] {
        let url = FileManager.documentDirectoryURL.appendingPathComponent(pathComponent).appendingPathExtension("json")
        let decoder = JSONDecoder()
        do {
            
            let data = try Data(contentsOf: url, options: [])
            let categories = try decoder.decode([Categories.Category].self, from: data)
            return categories
        } catch {
            print(error.localizedDescription)
            return []
        }
    }

    
    enum DecodingError: Error {
        case missingFile
    }
    
    enum CodingKeys: String, CodingKey {
        case categories = "results"
    }
    
    
    struct Category: Codable, Equatable {
        var id: Int
        var name: String
        
        init(id: Int, name: String) {
            self.id = id
            self.name = name
        }
        
        
        enum DecodingError: Error {
            case missingFile
        }
        
        enum CodingKeys: String, CodingKey {
            case id, name
        }
    }
        
    func allCategories() -> [Categories.Category] {
        return categories
    }
    
    func getCategoryTuple(for categoryName: String) -> (id: Int, index: Int) {
        if let index = categories.firstIndex(where: { $0.name == categoryName }) {
            let id = categories[index].id
            return (id, index)
        }
        return (0, 0)
    }
    
    
    
    
}
