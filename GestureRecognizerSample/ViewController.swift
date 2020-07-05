//
//  ViewController.swift
//  GestureRecognizerSample
//
//  Created by Kap's on 21/06/20.
//  Copyright © 2020 Kapil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fileImageView: UIImageView!
    @IBOutlet weak var trashImageView: UIImageView!
    
    var fileViewOrigin : CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.bringSubviewToFront(fileImageView)
        fileViewOrigin = fileImageView.frame.origin
        
        createGestureRecognizer(view: fileImageView)
    }
    
    func createGestureRecognizer(view : UIView) {
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handleGesture(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc func handleGesture(sender : UIPanGestureRecognizer) {
        
        let fileView = sender.view!
        
        switch sender.state {
            
        case .began, .changed :
             moveViewWithPan(view: fileView, sender: sender)
            
        case .ended :
            if fileView.frame.intersects(trashImageView.frame) {
                deleteView(view: fileView)
            } else {
                returnViewToOrigin(view: fileView)
            }
            
        default:
            break
        }
    }
    
    func moveViewWithPan(view : UIView, sender : UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: self.view)
        
        view.center  = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    func deleteView(view : UIView) {
        UIView.animate(withDuration: 0.3) {
            view.alpha = 0.0
        }
    }
    
    func returnViewToOrigin(view : UIView) {
        UIView.animate(withDuration: 0.3) {
            view.frame.origin = self.fileViewOrigin
        }
    }
}

