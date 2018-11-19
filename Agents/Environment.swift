//
//  Environment.swift
//  Agents
//
//

import Foundation
import Tin


class Environment {
    
    var food: [TVector2]
    
    init() {
        food = []
    }
    
    
    func addFood(x: Double, y: Double) {
        let v = TVector2(x: x, y: y)
        food.append(v)
    }
    
    
    func render() {
        for f in food {
            strokeDisable()
            fillColor(red: 0.1, green: 0.8, blue: 0.1, alpha: 1)
            ellipse(centerX: f.x, centerY: f.y, width: 8, height: 8)
        }
    }
    
}
