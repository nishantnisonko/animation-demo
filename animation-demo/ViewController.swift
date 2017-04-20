//
//  ViewController.swift
//  animation-demo
//
//  Created by Nishanko, Nishant on 4/19/17.
//  Copyright © 2017 Nishanko, Nishant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter : CGPoint!
    var newlyCreatedFace  : UIImageView!
    var newFaceInitialCenter : CGPoint!
    var isTrayOPen = true
    override func viewDidLoad() {
        super.viewDidLoad()
        trayOriginalCenter = trayView.center

        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTrayPanGesture(_ sender: UIPanGestureRecognizer) {
        
        let point = sender.location(in: trayView)
        
        if sender.state == .began {
            print("Gesture began at: \(point) ")
        } else if sender.state == .changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + sender.translation(in: trayView).y)
            print("Gesture changed at: \(point) \(sender.translation(in: trayView).y)")
        } else if sender.state == .ended {
            print("Gesture ended at: \(point)")
            let vpoint = sender.velocity(in: trayView)
            if vpoint.y > 0 {
                //down
                print("going down")
                isTrayOPen = false
                UIView.animate(withDuration : 0.3,  delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [],
                animations: {
                        self.trayView.center = CGPoint(x: self.trayOriginalCenter.x, y: self.trayOriginalCenter.y + 220)
                }, completion: nil)
                
//                UIView.animate(withDuration: 0.1, animations: {
//                    self.trayView.center = CGPoint(x: self.trayOriginalCenter.x, y: self.trayOriginalCenter.y + 220)
//                }, completion: nil)
            }else{
                //up
                print("going up")
                isTrayOPen = true

                UIView.animate(withDuration : 0.3,  delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [],
                animations: {
                    self.trayView.center = CGPoint(x: self.trayOriginalCenter.x, y: self.trayOriginalCenter.y)
                }, completion: nil)
                
            }
        }
        
    }
    
    @IBAction func onTapTray(_ sender: UITapGestureRecognizer) {
        if(isTrayOPen){
            isTrayOPen = false
            UIView.animate(withDuration : 0.3,  delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [],
                           animations: {
                            self.trayView.center = CGPoint(x: self.trayOriginalCenter.x, y: self.trayOriginalCenter.y + 220)
            }, completion: nil)
        }else{
            isTrayOPen = true
            
            UIView.animate(withDuration : 0.3,  delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [],
                           animations: {
                            self.trayView.center = CGPoint(x: self.trayOriginalCenter.x, y: self.trayOriginalCenter.y)
            }, completion: nil)
        }
    }
    
    func panNewlyAddedFace(_ sender: UIPanGestureRecognizer){
        if sender.state == .began {

        } else if sender.state == .changed {
            
        } else if sender.state == .ended {
        
        }
    }
    
    @IBAction func onDeadPan(_ sender: UIPanGestureRecognizer) {
        let imageView = sender.view as! UIImageView

        print(imageView.center)
        if sender.state == .began {
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newFaceInitialCenter = imageView.center
            var gr = UIPanGestureRecognizer(target: newlyCreatedFace, action: #selector(panNewlyAddedFace))
            newlyCreatedFace.addGestureRecognizer(gr)
            newlyCreatedFace.isUserInteractionEnabled = true
            print("Gesture began at:")
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newFaceInitialCenter.x + sender.translation(in: imageView).x, y: newFaceInitialCenter.y + sender.translation(in: imageView).y + trayView.frame.origin.y)
            print("Gesture changed at:  ")
        } else if sender.state == .ended {
            
            print("Gesture ended at:\(newlyCreatedFace.center)")
        }

        
    }
    

}

