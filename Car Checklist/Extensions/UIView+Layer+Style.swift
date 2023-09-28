//
//  UIView+Layer.swift
//  Car Checklist
//
//  Created by Nikita Kudinovich on 18.09.23.
//

import UIKit

extension UIView {
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    func setViewBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func setWarningStyle() {
        setViewBorder(width: 1.0, color: .systemRed)
        cornerRadius = 10.0
    }
    
    func setDefaultStyle() {
        setViewBorder(width: 1.0, color: .mainColor)
        cornerRadius = 10.0
    }
}
