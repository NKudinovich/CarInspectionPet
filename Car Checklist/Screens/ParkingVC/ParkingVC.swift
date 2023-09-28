//
//  ParkingVC.swift
//  Car Checklist
//
//  Created by Nikita Kudinovich on 18.09.23.
//

import UIKit
import Foundation

final class ParkingVC: UIViewController {
    
    //Outlet's views
    @IBOutlet private weak var addParkingDateView: UIView!
    @IBOutlet private weak var carMileageView: UIView!
    @IBOutlet private weak var priceParkingView: UIView!
    
    //Outlet's labels
    @IBOutlet private weak var addParkingLabel: UILabel!
    @IBOutlet private weak var carMileageLabel: UILabel!
    @IBOutlet private weak var priceParkingLabel: UILabel!
    
    //Outlet's text fields
    @IBOutlet private weak var carMileageTextField: UITextField!
    @IBOutlet private weak var priceParkingTextField: UITextField!
    
    //Outlet's buttons
    @IBOutlet private weak var saveButton: UIButton!
    
    //Outlet Date Picker
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIElements()
        loadData()
    }
    
    var delegate: MainVC?
    var mileage: String?
    
    //MARK: - Setup UI Elements
    private func setupUIElements() {
        self.view.backgroundColor = .mainBackground
        
        addParkingDateView.backgroundColor = .mainBackground
        addParkingDateView.setViewBorder(width: 1.0, color: .mainColor)
        addParkingDateView.cornerRadius = 10.0
        addParkingLabel.text = "Дата парковки"
        addParkingLabel.textColor = .white
        
        carMileageView.backgroundColor = .mainBackground
        carMileageView.setViewBorder(width: 1.0, color: .mainColor)
        carMileageView.cornerRadius = 10.0
        carMileageLabel.text = "Пробег, км"
        carMileageLabel.textColor = .white
        
        priceParkingView.backgroundColor = .mainBackground
        priceParkingView.setViewBorder(width: 1.0, color: .mainColor)
        priceParkingView.cornerRadius = 10.0
        priceParkingLabel.text = "Стоимость парковки, BYN"
        priceParkingLabel.textColor = .white
        saveButton.cornerRadius = 10.0
        saveButton.setViewBorder(width: 1.0, color: .mainColor)
        saveButton.tintColor = .white
        
        datePicker.contentHorizontalAlignment = .center
    }
    
    //MARK: - CoreData Load and Use
    private func loadData() {
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
        
        guard priceParkingTextField.hasText
        else {
            priceParkingTextField.setWarningStyle()
            priceParkingTextField.becomeFirstResponder()
            return false
        }
        priceParkingTextField.setDefaultStyle()
        
        return true
    }
    
    //MARK: - Save Data Func
    private func saveData() {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        let selectDate = datePicker.date
        
        guard
            let mileage = Int32(carMileageTextField.text ?? ""),
            let priceParking = Double(priceParkingTextField.text ?? "")
        else { return }
        
        
        let context = CoreDataService.context
        context.perform {
            let newParking = CarMO(context: context)
            newParking.generalPrice = priceParking
            newParking.mileage = mileage
            newParking.category = "Парковка"
            newParking.date = dateFormatter.string(from: selectDate)
            CoreDataService.saveContext()
            print("parkingData saved")
        }
    }
    
    //MARK: - IBActions
    @IBAction private func saveButtonDidTap() {
        
        if checkValidation() {
            saveData()
            navigationController?.popViewController(animated: true)
        }
    }
}
