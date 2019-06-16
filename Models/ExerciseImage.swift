//
//  ExerciseImage.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2019-02-03.
//  Copyright © 2019 Niklas Engsoo. All rights reserved.
//

import Foundation

struct ExerciseImageModel: Decodable {
    
    struct ExerciseImage: Decodable {
        let id: Int
        let imageUrl: String
        let isMain: Bool
        let exercise: Int
        
        enum CodingKeys: String, CodingKey {
            case id, isMain, exercise
            case imageUrl = "image"
        }
    }
    let images: [ExerciseImage]
    
    enum CodingKeys: String, CodingKey {
        case images = "results"
    }

}
