//
//  Circle.swift
//  AfterEight
//
//  Created by Niklas Engsoo on 2018-08-24.
//  Copyright © 2018 Niklas Engsoo. All rights reserved.
//

import UIKit

struct Circle {
    
    let fillColor: CGColor
    let strokeColor: CGColor
    let width: CGFloat
    let height: CGFloat
    let strokeWidth: CGFloat
    
    init(fillColor: CGColor, strokeColor: CGColor, width: CGFloat, height: CGFloat, strokeWidth: CGFloat) {
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.width = width
        self.height = height
        self.strokeWidth = strokeWidth
    }
    
    func drawCircle() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))
        
        let img = renderer.image { elips in
            elips.cgContext.setFillColor(fillColor)
            elips.cgContext.setStrokeColor(strokeColor)
            elips.cgContext.setLineWidth(strokeWidth)
            
            let rectangle = CGRect(x: strokeWidth/2, y: strokeWidth/2, width: width-strokeWidth, height: width-strokeWidth)
            elips.cgContext.addEllipse(in: rectangle)
            elips.cgContext.drawPath(using: .fillStroke)
        }
        return img
    }
}
