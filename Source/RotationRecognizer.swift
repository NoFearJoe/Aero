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
                    if let gravity = motion?.gravity {
                        self?.rotation = atan2(gravity.x, gravity.y) - .pi
                        print("\(self!.rotation)")
                    }
                }
            }
        }
    }
    
}
