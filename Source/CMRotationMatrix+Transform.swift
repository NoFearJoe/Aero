//
//  CMRotationMatrix+Transform.swift
//  AeroDemo
//
//  Created by Ilya Kharabet on 01.02.17.
//  Copyright © 2017 Mesterra. All rights reserved.
//

import UIKit
import CoreMotion


extension CMAttitude {

    public func transform3D(_ includePitch: Bool, _ includeRoll: Bool, _ includeYaw: Bool) -> CATransform3D {
        let yawTransform = includeYaw ? CATransform3DMakeRotation(CGFloat(yaw), 0, 0, 1) : CATransform3DIdentity
        let rollTransform = includeRoll ? CATransform3DMakeRotation(CGFloat(roll), 0, 1, 0) : CATransform3DIdentity
        let pitchTransform = includePitch ? CATransform3DMakeRotation(CGFloat(pitch), 1, 0, 0) : CATransform3DIdentity
        
        let combinedTransform1 = CATransform3DConcat(CATransform3DIdentity, yawTransform)
        let combinedTransform2 = CATransform3DConcat(combinedTransform1, rollTransform)
        let combinedTransform3 = CATransform3DConcat(combinedTransform2, pitchTransform)
        
        return combinedTransform3
    }

    
    public var affineTransform: CGAffineTransform {
        return CATransform3DGetAffineTransform(transform3D(true, true, true))
    }

}


extension CMRotationMatrix {

    public var transform3D: CATransform3D {
        return CATransform3D(m11: CGFloat(m11), m12: CGFloat(m12), m13: CGFloat(m13), m14: 0,
                             m21: CGFloat(m21), m22: CGFloat(m22), m23: CGFloat(m23), m24: 0,
                             m31: CGFloat(m31), m32: CGFloat(m32), m33: CGFloat(m33), m34: 0,
                             m41: 0, m42: 0, m43: 0, m44: 0)
    }
    
    public var affineTransform: CGAffineTransform {
        return CATransform3DGetAffineTransform(transform3D)
    }

}

extension CATransform3D {

    public func withoutYaw() -> CATransform3D {
        return CATransform3D(m11: 0, m12: 0, m13: 0, m14: 0,
                             m21: m21, m22: m22, m23: m23, m24: 0,
                             m31: m31, m32: m32, m33: m33, m34: 0,
                             m41: 0, m42: 0, m43: 0, m44: 0)
    }
    
    public func withoutRoll() -> CATransform3D {
        return CATransform3DRotate(self, 0, 0, 1, 0)
    }
    
    public func withoutPitch() -> CATransform3D {
        return CATransform3D(m11: m11, m12: m12, m13: m13, m14: 0,
                             m21: m21, m22: m22, m23: m23, m24: 0,
                             m31: m31, m32: m32, m33: m33, m34: 0,
                             m41: 0, m42: 0, m43: 0, m44: 0)
    }
    
    
    public var affineTransform: CGAffineTransform {
        return CATransform3DGetAffineTransform(self)
    }

}
