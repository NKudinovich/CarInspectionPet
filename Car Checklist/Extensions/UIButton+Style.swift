//
//  UIButton+Style.swift
//  Car Checklist
//
//  Created by Nikita Kudinovich on 18.09.23.
//

import UIKit

extension UIButton {
    func setupMainStyle() {
        
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 10.0
        self.layer.borderWidth = 1.0
    }
}
