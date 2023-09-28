//
//  UIColor+Palette.swift
//  Car Checklist
//
//  Created by Nikita Kudinovich on 18.09.23.
//

import UIKit

extension UIColor {
    convenience init(r: Int, g: Int, b: Int, a: CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255,
                  green: CGFloat(g) / 255,
                  blue: CGFloat(b) / 255,
                  alpha: a)
    }
    static var mainBackground: UIColor {
        return UIColor(r: 13, g: 13, b: 13, a: 1)
    }
    
    static var mainColor: UIColor {
        return UIColor(r: 242, g: 154, b: 46, a: 1)
    }
    
    static var lightOrange: UIColor {
        return UIColor(r: 242, g: 197, b: 114, a: 1)
    }
    
    static var darkBrown: UIColor {
        return UIColor(r: 64, g: 54, b: 43)
    }
    
    static var underButtonsBackground: UIColor {
        return UIColor(r: 26, g: 26, b: 26)
    }
}
