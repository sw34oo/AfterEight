//
//  Muscle.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-07-30.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import Foundation

class Muscles: Codable {
    let id: Int
    let name: String
    let isFront: Bool
    
    init(id: Int, name: String, isFront: Bool) {
        self.id = id
        self.name = name
        self.isFront = isFront
    }
}
