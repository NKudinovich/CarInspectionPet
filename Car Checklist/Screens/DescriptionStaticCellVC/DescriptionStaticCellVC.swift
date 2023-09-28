//
//  DescriptionStaticCellVC.swift
//  Car Checklist
//
//  Created by Nikita Kudinovich on 20.09.23.
//

import UIKit

final class DescriptionStaticCellVC: UIViewController {
    @IBOutlet private weak var testLabel: UILabel!
    @IBOutlet private weak var textView: UITextView!
    
    var test: CarMO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIElements()
    }
    
    private func setupUIElements() {
        textView.setViewBorder(width: 1.0, color: .mainColor)
    }
    
    private func loadInfo() {
        testLabel.text = test?.category
        textView.text = test?.serviceDescription
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadInfo()
    }
}
