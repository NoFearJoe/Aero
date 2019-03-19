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
    
    
    fileprivate let motionManager = CMMotionManager()
    fileprivate let operationQueue = OperationQueue()
    
    
    override init(subscriber: Subscriber, action: @escaping Action) {
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
        attitude = motion?.attitude
    }

}
