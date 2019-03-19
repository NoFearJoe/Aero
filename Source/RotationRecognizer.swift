//
//  RotationRecognizer.swift
//  AeroDemo
//
//  Created by Ilya Kharabet on 02.02.17.
//  Copyright © 2017 Mesterra. All rights reserved.
//

import CoreMotion
import CoreGraphics


public struct AirRotation {
    let x: CGFloat
    let y: CGFloat
    let z: CGFloat
    
    static let zero = AirRotation(x: 0, y: 0, z: 0)
}

open class RotationRecognizer: MotionRecognizer {
    
    public var rotation: Double = 0 {
        didSet {
            state = .changed
        }
    }
    
    public var airRotation: AirRotation = .zero {
        didSet {
            state = .changed
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
        if let rotationRate = motion?.rotationRate {
            airRotation = AirRotation(x: CGFloat(rotationRate.x) * -1,
                                      y: CGFloat(rotationRate.y) * -1,
                                      z: CGFloat(rotationRate.z) * -1)
        }
    }
    
}
