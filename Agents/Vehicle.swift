//
//  Vehicle.swift
//  Agents
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com
//

import Foundation
import Tin


class Vehicle {
    var position: TVector2
    var velocity: TVector2
    var acceleration: TVector2
    var r: Double
    var maxforce: Double
    var maxspeed: Double
    
    
    // MARK: - Initializer
    
    init(x: Double, y: Double) {
        acceleration = TVector2()
        let vx = randomGaussian() * 6.0
        let vy = randomGaussian() * 6.0
        velocity = TVector2(x: vx, y: vy)
        position = TVector2(x: x, y: y)
        r = 4.0
        maxspeed = 4.0
        maxforce = 0.1
    }
    
    
    // MARK: - Instance Methods
    
    // run
    // One method to be called from the Scene object, which will handle
    // all the movement, then the rendering of this vehicle.
    func run(env: Environment) {
        update()
        borders()
        display()
    }
    
    
    // borders
    // wrap the vehicle from one edge to the opposite edge when it
    // exits the view.
    func borders() {
        if position.x + r < 0.0 {
            // exited the left edge
            position.x = tin.width + r
        }
        else if position.x - r > tin.width {
            // exited the right edge
            position.x = -r
        }
        if position.y + r < 0.0 {
            // exited the bottom edge
            position.y = tin.height + r
        }
        else if position.y - r > tin.height {
            // exited the top edge
            position.y = -r
        }
    }
    
    
    // update
    // Resolve all movement for vehicle by applying
    // acceleration to velocity, and velocity to position.
    func update() {
        velocity = velocity + acceleration
        velocity.limit(mag: maxspeed)
        position = position + velocity
        acceleration = acceleration * 0.0
    }
    
    
    // apply a force vector, changing acceleration.
    func apply(force: TVector2) {
        acceleration = acceleration + force
    }
    
    
    // Seek to a target position.
    // Compute a steering vector, then apply that force.
    func seek(target: TVector2) {
        var desired = target - position
        desired.normalize()
        desired = desired * maxspeed
        
        var steer = desired - velocity
        steer.limit(mag: maxforce)
        
        apply(force: steer)
    }
    
    func arrive(target: TVector2) {
        var desired = target - position
        let d = desired.magnitude
        if d < 100.0 {
            let m = remap(value: d, start1: 0.0, stop1: 100.0, start2: 0, stop2: maxspeed)
            desired.magnitude = m
        }
        else {
            desired.magnitude = maxspeed
        }
        
        var steer = desired - velocity
        steer.limit(mag: maxforce)
        
        apply(force: steer)
    }
    
    
    func display() {
        let theta = velocity.heading() + .pi / 2.0
        fillColor(gray: 0.5)
        strokeColor(gray: 0.0)
        lineWidth(1.0)
        pushState()
        translate(dx: position.x, dy: position.y)
        rotate(by: theta)
        pathBegin()
        pathVertex(x: 0.0, y: -r * 2.0)
        pathVertex(x: -r, y: r * 2.0)
        pathVertex(x:  r, y: r * 2.0)
        pathClose()
        pathEnd()
        popState()
    }
}
