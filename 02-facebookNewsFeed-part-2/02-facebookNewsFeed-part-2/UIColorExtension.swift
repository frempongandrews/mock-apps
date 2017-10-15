//
//  UIColorExtension.swift
//  02-facebookNewsFeed-part-2
//
//  Created by Andrews Frempong on 14/10/2017.
//  Copyright © 2017 Andrews Frempong. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func customRgb (r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        
        return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
        
    }
    
}

