//
//  StatisticCell.swift
//  Car Checklist
//
//  Created by Nikita Kudinovich on 20.09.23.
//

import UIKit

final class StatisticCell: UITableViewCell {
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var mileage: UILabel!
    @IBOutlet weak var openDescription: UILabel! {
        didSet {
            openDescription.isHidden = true
        }
    }
}
