//
//  Exercise.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-07-30.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import Foundation

class Exercise: Codable {
    
    let name: String
    let category: Category
    let description: String
    let muscles: [Muscles]
    let musclesSecondary: [MusclesSecondary]
    let equipment: [Equipment]
    
    
    init(name: String, category: Category, description: String, muscles: [Muscles], musclesSecondary: [MusclesSecondary], equipment: [Equipment]) {
        
        self.name = name
        self.category = category
        self.description = description
        self.muscles = muscles
        self.musclesSecondary = musclesSecondary
        self.equipment = equipment
    }
}
