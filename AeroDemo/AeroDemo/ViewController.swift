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

    var v: UIView!
    var r: TiltRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        v = UIView(frame: CGRect(origin: view.center, size: CGSize(width: 100, height: 100)))
        v.center = view.center
        v.backgroundColor = .brown
        view.addSubview(v)
        
        r = TiltRecognizer(subscriber: self, action: { [weak self] rec in
            OperationQueue.main.addOperation { [weak self] in
                if let tiltRec = rec as? TiltRecognizer {
                    if let att = tiltRec.attitude {
//                        let m = att.rotationMatrixs
                        self?.v?.transform = att.transform3D(false, false, true).affineTransform // m.transform3D.withoutRoll().affineTransform //CGAffineTransform(rotationAngle: CGFloat(att.roll))
                    }
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.        
    }


}

