//
//  MotionRecognizer.swift
//  AeroDemo
//
//  Created by Ilya Kharabet on 01.02.17.
//  Copyright © 2017 Mesterra. All rights reserved.
//

import Foundation


public enum MotionRecognizerState: Int {

    /// The recognizer has not recognized motion. Default state
    case possible = 0
    
    /// The recognizer has recognized motion
    case began = 1
    
    /// Motion parameters changed
    case changed = 2
    
    /// Motion ended
    case ended = 3

}


/// Base class for all motion recognizers
open class MotionRecognizer: NSObject {

    public typealias Subscriber = AnyHashable
    public typealias Action = ((MotionRecognizer) -> Void)?
    
    fileprivate var subscribers: [Subscriber: Action] = [:]
    
    /// If false, motions will not be recognized. Default is true
    public var isEnabled: Bool = true
    
    /// Current recognizer state
    internal(set) var state: MotionRecognizerState = .possible {
        didSet {
            notifySubscribers()
        }
    }
    
    
    public init(subscriber: Subscriber, action: Action) {
        super.init()

        self.subscribers[subscriber] = action
    }
    
    
    open func subscribe(subscriber: Subscriber, action: Action) {
        self.subscribers[subscriber] = action
    }
    
    open func unsubscribe(subscriber: Subscriber) {
        self.subscribers.removeValue(forKey: subscriber)
    }
    
    
    fileprivate func notifySubscribers() {
        OperationQueue.main.addOperation { [weak self] in
            guard let `self` = self else  { return }
            self.subscribers.values.forEach { $0?(self) }
        }
    }

}
