//
//  RotationRecognizer.swift
//  AeroDemo
//
//  Created by Ilya Kharabet on 02.02.17.
//  Copyright © 2017 Mesterra. All rights reserved.
//

import CoreMotion


open class RotationRecognizer: MotionRecognizer {
    
    public var rotation: Double = 0 {
        didSet {
            state = .changed
        }
    }
    
    fileprivate let motionManager: CMMotionManager
    fileprivate let operationQueue = OperationQueue()
    
    
    override init(subscriber: Subscriber, action: Action) {
        motionManager = CMMotionManager()
        
        super.init(subscriber: subscriber, action: action)
        
        setupMotionManager()
    }
    
    
    fileprivate func setupMotionManager() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.01
            motionManager.startDeviceMotionUpdates(to: operationQueue) { [weak self] (motion, error) in
                OperationQueue.main.addOperation { [weak self] in
                    self?.handleMotion(motion, error: error)
                }
            }
        }
    }
    
    fileprivate func handleMotion(_ motion: CMDeviceMotion?, error: Error?) {
        if let gravity = motion?.gravity {
            rotation = atan2(gravity.x, gravity.y) - .pi
        }
    }
    
}
