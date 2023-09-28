//
//  CarWashingVC.swift
//  Car Checklist
//
//  Created by Nikita Kudinovich on 18.09.23.
//

import UIKit

final class CarWashingVC: UIViewController {
    
    //Outlet's views
    @IBOutlet private weak var addCarWashingDateView: UIView!
    @IBOutlet private weak var carMileageView: UIView!
    @IBOutlet private weak var priceCarWashingView: UIView!
    
    //Outlet's labels
    @IBOutlet private weak var addCarWashingLabel: UILabel!
    @IBOutlet private weak var carMileageLabel: UILabel!
    @IBOutlet private weak var priceCarWashingLabel: UILabel!
    
    //Outlet's text fields
    @IBOutlet private weak var carMileageTextField: UITextField!
    @IBOutlet private weak var priceCarWashingTextField: UITextField!
    
    //Outlet's buttons
    @IBOutlet private weak var saveButton: UIButton!
    
    //Outlet date picker
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    var delegate: MainVC?
    var mileage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        carMileageTextField.placeholder = mileage
    }
    
    //MARK: - Check text fields rules
    private func checkValidation() -> Bool {
        guard carMileageTextField.hasText
        else {
            carMileageTextField.setWarningStyle()
            carMileageTextField.becomeFirstResponder()
            return false
        }
        carMileageTextField.setDefaultStyle()
        
        guard priceCarWashingTextField.hasText
        else {
            priceCarWashingTextField.setWarningStyle()
            priceCarWashingTextField.becomeFirstResponder()
            return false
        }
        priceCarWashingTextField.setDefaultStyle()
        
        return true
    }
    
    
    //MARK: - Save Data Func
    private func saveData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        let selectedDate = datePicker.date
        
        guard
            let mileage = Int32(carMileageTextField.text ?? ""),
            let priceCarWash = Double(priceCarWashingTextField.text ?? "")
        else { return }
        
        let context = CoreDataService.context
        
        context.perform {
            let newWash = CarMO(context: context)
            newWash.mileage = mileage
            newWash.generalPrice = priceCarWash
            newWash.date = dateFormatter.string(from: selectedDate)
            newWash.category = "Мойка"
            CoreDataService.saveContext()
            print("CarWash saved data")
        }
    }
    
    //MARK: - Setup UI Elements
    private func setupUIElements() {
        self.view.backgroundColor = .mainBackground
        
        addCarWashingDateView.backgroundColor = .mainBackground
        addCarWashingDateView.setViewBorder(width: 1.0, color: .mainColor)
        addCarWashingDateView.cornerRadius = 10.0
        addCarWashingLabel.text = "Дата мойки"
        addCarWashingLabel.textColor = .white
        
        carMileageView.backgroundColor = .mainBackground
        carMileageView.setViewBorder(width: 1.0, color: .mainColor)
        carMileageView.cornerRadius = 10.0
        carMileageLabel.text = "Пробег"
        carMileageLabel.textColor = .white
        
        priceCarWashingView.backgroundColor = .mainBackground
        priceCarWashingView.setViewBorder(width: 1.0, color: .mainColor)
        priceCarWashingView.cornerRadius = 10.0
        priceCarWashingTextField.backgroundColor = .mainBackground
        priceCarWashingLabel.text = "Стоимость мойки, BYN"
        priceCarWashingLabel.textColor = .white
        
        saveButton.cornerRadius = 10.0
        saveButton.setViewBorder(width: 1.0, color: .mainColor)
        saveButton.tintColor = .white
        
        datePicker.contentHorizontalAlignment = .center
    }
    
    //MARK: - IBActions
    @IBAction private func saveButtonDidTap() {
        if checkValidation() {
            saveData()
            navigationController?.popViewController(animated: true)
        }
    }
}




