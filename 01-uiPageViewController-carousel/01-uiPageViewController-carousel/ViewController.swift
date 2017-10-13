//
//  ViewController.swift
//  01-uiPageViewController-carousel
//
//  Created by Andrews Frempong on 25/09/2017.
//  Copyright © 2017 Andrews Frempong. All rights reserved.
//

import UIKit

class CustomPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var slides:[UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //giving control
        self.dataSource = self
        
        let frameViewController1 = FrameViewController()
        frameViewController1.frameImage = #imageLiteral(resourceName: "movie2")
        
        slides.append(frameViewController1)
        
        
        //getting the array of viewControllers to show
        //to be done in viewDidLoad
        setViewControllers(slides, direction: .forward, animated: true, completion: nil)
        
   
        
        
        
    } /////////End of viewDidLoad
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    
}/////////End of CustomPageViewController

class FrameViewController: UIViewController {
    
    var frameImage: UIImage? {
        didSet {
            imageView.image = frameImage
        }
    }
    
    let imageView: UIImageView = {
       
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        //remove frame layout
        iv.translatesAutoresizingMaskIntoConstraints = false
        
        return iv
        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = .black
        
        view.addSubview(imageView)
        
        //constraints
        
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        
        
    }



}

