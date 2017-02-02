//
//  AirGestureRecognizer.swift
//  AeroDemo
//
//  Created by Ilya Kharabet on 02.02.17.
//  Copyright © 2017 Mesterra. All rights reserved.
//

import CoreMotion


enum AirGestureAxis: Int {
    case vertical = 0
    case horizontal = 1
    case longitudinally = 2
}

enum AirGestureDirection: Int {
    case negative = 0
    case positive = 1
}

open class AirGestureRecognizer: MotionRecognizer {
    
    var treshold: Double = 2.5
    var axis: AirGestureAxis = .horizontal
    var direction: AirGestureDirection = .negative
    
    
    fileprivate let motionManager: CMMotionManager
    fileprivate let operationQueue = OperationQueue()
    
    
    fileprivate var recognized: Bool = false
    
    
    override init(subscriber: Subscriber, action: Action) {
        motionManager = CMMotionManager()
        
        super.init(subscriber: subscriber, action: action)
        
        setupMotionManager()
    }
    
    
    fileprivate func setupMotionManager() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.02
            motionManager.startDeviceMotionUpdates(to: operationQueue) { [weak self] (motion, error) in
                OperationQueue.main.addOperation { [weak self] in
                    guard let `self` = self else { return }
                    
                    if let acceleration = motion?.userAcceleration {
                        switch self.axis {
                        case .vertical:
                            if !self.recognized && (self.direction == .positive && acceleration.y >= self.treshold || self.direction == .negative && acceleration.y <= -self.treshold) {
                                self.state = .changed
                                self.recognized = true
                            } else {
                                self.recognized = false
                            }
                        case .horizontal:
                            if !self.recognized && (self.direction == .positive && acceleration.x >= self.treshold || self.direction == .negative && acceleration.x <= -self.treshold) {
                                self.state = .changed
                                self.recognized = true
                            } else {
                                self.recognized = false
                            }
                        case .longitudinally:
                            if !self.recognized && (self.direction == .positive && acceleration.z >= self.treshold || self.direction == .negative && acceleration.z <= -self.treshold) {
                                self.state = .changed
                                self.recognized = true
                            } else {
                                self.recognized = false
                            }
                        }
                    }
                }
            }
        }
    }
    
}
