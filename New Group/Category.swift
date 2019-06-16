//
//  Category.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-07-30.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import Foundation

class Category: Codable {
    
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}


extension Category: Hashable {
    
    var hashValue: Int {
        return id.hashValue ^ name.hashValue
    }
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}


