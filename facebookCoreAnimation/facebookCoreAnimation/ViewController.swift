//
//  ViewController.swift
//  facebookCoreAnimation
//
//  Created by Andrews Frempong on 03/11/2017.
//  Copyright © 2017 Andrews Frempong. All rights reserved.
//

import UIKit

let startingFrame = CGRect(x: 0, y: 0, width: 200, height: 100)
var isZoomed = false
class ViewController: UIViewController {
    
    let zoomImageView: UIView = {
        let z = UIView()
        z.backgroundColor = .blue
        
        z.translatesAutoresizingMaskIntoConstraints = false
        return z
        
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //use frames fro core animation
        zoomImageView.frame = startingFrame
        
        zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.animate)))
        view.addSubview(zoomImageView)
    }
    
    @objc func animate () {
        
        //h2 = w1/w2 * h1
        
        let endingFrame = CGRect(x: 0, y: 0, width: startingFrame.width, height: startingFrame.height)
        
        if isZoomed {
            
            UIView.animate(withDuration: 1, animations: {
                self.zoomImageView.frame = endingFrame
            })
            
            isZoomed = false
            
        } else {
            
            
            
            let newHeight = (view.frame.width/startingFrame.width) * startingFrame.height
            
            let middleY = view.frame.height / 2 - newHeight/2
            UIView.animate(withDuration: 0.8) {
                self.zoomImageView.frame = CGRect(x: 0, y: middleY, width: self.view.frame.width, height: newHeight)
                
                isZoomed = true
            }
        
        }
    }

}

