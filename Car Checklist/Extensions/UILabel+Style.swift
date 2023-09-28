//
//  UILabel+Style.swift
//  Car Checklist
//
//  Created by Nikita Kudinovich on 18.09.23.
//

import UIKit

extension UILabel {
    func setLabelStyle() {
        self.layer.cornerRadius = 10.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.mainColor.cgColor
        self.textColor = .white
    }
}
