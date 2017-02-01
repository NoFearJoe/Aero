//
//  TiltRecognizer.swift
//  AeroDemo
//
//  Created by Ilya Kharabet on 01.02.17.
//  Copyright © 2017 Mesterra. All rights reserved.
//

import CoreMotion


open class TiltRecognizer: MotionRecognizer {

    public var attitude: CMAttitude? {
        didSet {
            if attitude != nil {
                state = .changed
            } else {
                state = .possible
            }
        }
    }
    
    
    fileprivate let motionManager: CMMotionManager
    
    
    override init(subscriber: Subscriber, action: Action) {
        motionManager = CMMotionManager()

        super.init(subscriber: subscriber, action: action)
        
        setupMotionManager()
    }
    
    
    fileprivate func setupMotionManager() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.01
            motionManager.startDeviceMotionUpdates(to: OperationQueue()) { [weak self] (motion, error) in
                if let motion = motion {
                    self?.attitude = motion.attitude
                }
            }
        }
    }

}
