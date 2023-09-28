//
//  ServiceVC.swift
//  Car Checklist
//
//  Created by Nikita Kudinovich on 19.09.23.
//

import UIKit

final class ServiceVC: UIViewController, UITextViewDelegate {
    //Outlet's date picker view
    @IBOutlet private weak var datePickerView: UIView!
    @IBOutlet private weak var datePickerViewLabel: UILabel!
    
    
    //Outlet's car mileage view
    @IBOutlet private weak var carMileageView: UIView!
    @IBOutlet private weak var carMileageViewLabel: UILabel!
    @IBOutlet private weak var carMileageViewTextField: UITextField!
    
    //Outlet's price service view
    @IBOutlet private weak var priceServiceView: UIView!
    @IBOutlet private weak var priceServiceViewLabel: UILabel!
    @IBOutlet private weak var priceServiceViewTextField: UITextField!
    
    //Outlet's description view
    @IBOutlet private weak var descriptionView: UIView!
    @IBOutlet private weak var descriptionViewLabel: UILabel!
    @IBOutlet private weak var descriptionViewTextView: UITextView!
    
    //Outlet's buttons
    @IBOutlet private weak var serviceSaveButton: UIButton!
    
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
        
        carMileageViewTextField.placeholder = mileage
    }
    
    //MARK: - Check text fields rules
    private func checkValidation() -> Bool {
        guard carMileageViewTextField.hasText
        else {
            carMileageViewTextField.setWarningStyle()
            carMileageViewTextField.becomeFirstResponder()
            return false
        }
        carMileageViewTextField.setDefaultStyle()
        
        guard priceServiceViewTextField.hasText
        else {
            priceServiceViewTextField.setWarningStyle()
            priceServiceViewTextField.becomeFirstResponder()
            return false
        }
        priceServiceViewTextField.setDefaultStyle()
        
        return true
    }
    
    //MARK: - Save Data Func
    private func saveData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        let selectedDate = datePicker.date
        
        guard
            let mileage = Int32(carMileageViewTextField.text ?? ""),
            let priceService = Double(priceServiceViewTextField.text ?? ""),
            let descriptionService = descriptionViewTextView.text
        else { return }
        
        let context = CoreDataService.context
        context.perform {
            let newService = CarMO(context: context)
            newService.mileage = mileage
            newService.generalPrice = priceService
            newService.serviceDescription = descriptionService
            newService.date = dateFormatter.string(from: selectedDate)
            newService.category = "Сервис"
            CoreDataService.saveContext()
            print("serviceData saved")
        }
    }
    
    //MARK: - CoreDada Load and Use
    private func loadData() {
        carMileageViewTextField.text = mileage
    }
    
    
    //MARK: - Setup UI Elements
    private func setupUIElements() {
        //view's
        self.view.backgroundColor = .mainBackground
        datePickerView.backgroundColor = .mainBackground
        carMileageView.backgroundColor = .mainBackground
        priceServiceView.backgroundColor = .mainBackground
        descriptionView.backgroundColor = .mainBackground
        
        datePickerView.setViewBorder(width: 1.0, color: .mainColor)
        carMileageView.setViewBorder(width: 1.0, color: .mainColor)
        priceServiceView.setViewBorder(width: 1.0, color: .mainColor)
        descriptionView.setViewBorder(width: 1.0, color: .mainColor)
        
        datePickerView.cornerRadius = 10.0
        carMileageView.cornerRadius = 10.0
        priceServiceView.cornerRadius = 10.0
        descriptionView.cornerRadius = 10.0
        
        //labels
        datePickerViewLabel.textColor = .white
        carMileageViewLabel.textColor = .white
        priceServiceViewLabel.textColor = .white
        descriptionViewLabel.textColor = .white
        
        datePickerViewLabel.text = "Дата"
        carMileageViewLabel.text = "Пробег"
        priceServiceViewLabel.text = "Стоимость, BYN"
        descriptionViewLabel.text = "Описание"
        
        //textField/textView and date picker
        datePicker.tintColor = .mainColor
        carMileageViewTextField.backgroundColor = .mainBackground
        priceServiceViewTextField.backgroundColor = .mainBackground
        descriptionViewTextView.backgroundColor = .mainBackground
        
        //button
        serviceSaveButton.tintColor = .white
        serviceSaveButton.cornerRadius = 10.0
        serviceSaveButton.setViewBorder(width: 1.0, color: .mainColor)
        
        //date picker
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
