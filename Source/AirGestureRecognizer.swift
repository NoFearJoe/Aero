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
    
    
    fileprivate let motionManager = CMMotionManager()
    fileprivate let operationQueue = OperationQueue()
    
    
    fileprivate var recognized: Bool = false {
        didSet {
            OperationQueue.main.addOperation {
                if self.recognized {
                    self.state = .changed
                    self.state = .possible
                }
            }
        }
    }
    
    
    override init(subscriber: Subscriber, action: @escaping Action) {
        super.init(subscriber: subscriber, action: action)
        setupMotionManager()
    }
    
    
    fileprivate func setupMotionManager() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.02
            motionManager.startDeviceMotionUpdates(to: operationQueue) { [unowned self] (motion, error) in
                self.handleMotion(motion, error: error)
            }
        }
    }
    
    fileprivate func handleMotion(_ motion: CMDeviceMotion?, error: Error?) {
        if let acceleration = motion?.userAcceleration {
            switch self.axis {
            case .vertical:
                recognized = direction == .positive && acceleration.y >= treshold || direction == .negative && acceleration.y <= -treshold
            case .horizontal:
                recognized = direction == .positive && acceleration.x >= treshold || direction == .negative && acceleration.x <= -treshold
            case .longitudinally:
                recognized = direction == .positive && acceleration.z >= treshold || direction == .negative && acceleration.z <= -treshold
            }
        }
    }
    
}
