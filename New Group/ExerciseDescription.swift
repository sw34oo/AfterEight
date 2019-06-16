//
//  ExerciseDescription.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-07-30.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import Foundation

class ExerciseDescription: Codable {
    let results: [Exercise]
    
    init(results: [Exercise]) {
        self.results = results
    }
}

