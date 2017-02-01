//
//  MotionRecognizer.swift
//  AeroDemo
//
//  Created by Ilya Kharabet on 01.02.17.
//  Copyright © 2017 Mesterra. All rights reserved.
//



public enum MotionRecognizerState: Int {

    /// The recognizer has not recognized motion. Default state
    case possible = 0
    
    /// The recognizer has recognized motion
    case began = 1
    
    /// Motion parameters changed
    case changed = 2
    
    /// Motion ended
    case ended = 3
    
    /// Motion cancelled
    case cancelled = 4
    
    /// Motion recognition failed
    case failed = 5
    
    
//    public static var recognized: MotionRecognizerState { get }

}
