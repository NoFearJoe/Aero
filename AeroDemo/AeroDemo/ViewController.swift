//
//  ViewController.swift
//  AeroDemo
//
//  Created by Ilya Kharabet on 01.02.17.
//  Copyright © 2017 Mesterra. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    var v: UIImageView!
    var r: RotationRecognizer!
    
    var agr: AirGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        v = UIImageView(frame: CGRect(origin: view.center, size: CGSize(width: 972, height: 1728)))
        v.image = #imageLiteral(resourceName: "Background")
        v.center = view.center
        v.backgroundColor = .brown
        view.addSubview(v)
        v.alpha = 1
        
//        r = RotationRecognizer(subscriber: self, action: { [weak self] rec in
//            if let tiltRec = rec as? RotationRecognizer {
////                if let att = tiltRec.attitude {
//                    UIView.animate(withDuration: 0.05,
//                                   delay: 0,
//                                   options: [UIViewAnimationOptions.beginFromCurrentState, .curveEaseOut, .allowUserInteraction],
//                                   animations: { [weak self] in
//                                       //self?.v?.transform = CGAffineTransform(rotationAngle: CGFloat(tiltRec.rotation)) //att.transform3D(false, false, true).affineTransform
//                                       self?.v?.alpha += tiltRec.airRotation.z / 50
//                                   },
//                                   completion: nil)
//                }
////            }
//        })
        
        agr = AirGestureRecognizer(subscriber: self, action: { [unowned self] rec in
            if rec.state == .changed {
                self.v?.alpha -= 0.1
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }


}

