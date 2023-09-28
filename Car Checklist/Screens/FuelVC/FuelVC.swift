//
//  FuelVC.swift
//  Car Checklist
//
//  Created by Nikita Kudinovich on 18.09.23.
//

import UIKit

protocol FuelVCProtocole {
    func didSelect(fuel: String)
}

final class FuelVC: UIViewController, FuelVCProtocole {
    
    //Outlet's views
    @IBOutlet private weak var addFuelDataView: UIView!
    //    @IBOutlet private weak var chooseFuelStationView: UIView!
    @IBOutlet private weak var amountFuelView: UIView!
    @IBOutlet private weak var carMileageView: UIView!
    @IBOutlet private weak var fuelTypeView: UIView!
    @IBOutlet private weak var fuelVolumeView: UIView!
    @IBOutlet private weak var pricePerLiterFuelView: UIView!
    
    //Outlet's labels
    @IBOutlet private weak var chooseDateLabel: UILabel!
    //    @IBOutlet private weak var chooseFuelStationLabel: UILabel!
    @IBOutlet private weak var amountBYNLabel: UILabel!
    @IBOutlet private weak var carMileageLabel: UILabel!
    @IBOutlet private weak var fuelTypeLabel: UILabel!
    @IBOutlet private weak var fuelVolumeLabel: UILabel!
    @IBOutlet private weak var pricePerLiterFuelLabel: UILabel!
    
    //Outlet's text fields
    @IBOutlet private weak var amountBYNTextField: UITextField!
    @IBOutlet private weak var carMileageTextField: UITextField!
    @IBOutlet private weak var fuelVolumeTextField: UITextField!
    @IBOutlet private weak var pricePerLiterFuelTextField: UITextField!
    
    //Outlet date picker
    @IBOutlet private weak var datePicker: UIDatePicker!
    
    //Outlet's buttons
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var changeFuelTypeButton: UIButton!
    
    var delegate: MainVC?
    var mileage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIElements()
        setupTapGesture()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - Setup UI Elements
    
    private func setupUIElements() {
        self.view.backgroundColor = .mainBackground
        
        addFuelDataView.backgroundColor = .mainBackground
        addFuelDataView.setViewBorder(width: 1.0, color: .mainColor)
        addFuelDataView.cornerRadius = 10.0
        chooseDateLabel.text = "Дата заправки"
        chooseDateLabel.textColor = .white
        
        amountFuelView.backgroundColor = .mainBackground
        amountFuelView.setViewBorder(width: 1.0, color: .mainColor)
        amountFuelView.cornerRadius = 10.0
        amountBYNLabel.text = "Сумма, BYN"
        amountBYNLabel.textColor = .white
        amountBYNTextField.textColor = .white
        
        carMileageView.backgroundColor = .mainBackground
        carMileageView.setViewBorder(width: 1.0, color: .mainColor)
        carMileageView.cornerRadius = 10.0
        carMileageLabel.text = "Пробег, км"
        carMileageLabel.textColor = .white
        
        fuelTypeView.backgroundColor = .mainBackground
        fuelTypeView.setViewBorder(width: 1.0, color: .mainColor)
        fuelTypeView.cornerRadius = 10.0
        fuelTypeLabel.text = "Вид топлива"
        fuelTypeLabel.textColor = .white
        
        fuelVolumeView.backgroundColor = .mainBackground
        fuelVolumeView.setViewBorder(width: 1.0, color: .mainColor)
        fuelVolumeView.cornerRadius = 10.0
        fuelVolumeLabel.text = "Объем, л"
        fuelVolumeLabel.textColor = .white
        fuelVolumeTextField.textColor = .white
        
        pricePerLiterFuelView.backgroundColor = .mainBackground
        pricePerLiterFuelView.setViewBorder(width: 1.0, color: .mainColor)
        pricePerLiterFuelView.cornerRadius = 10.0
        pricePerLiterFuelLabel.text = "Цена за 1л"
        pricePerLiterFuelLabel.textColor = .white
        
        datePicker.tintColor = .lightOrange
        
        pricePerLiterFuelTextField.textColor = .white
        
        amountBYNTextField.delegate = self
        pricePerLiterFuelTextField.delegate = self
        fuelVolumeTextField.delegate = self
        carMileageTextField.delegate = self
        
        saveButton.backgroundColor = .mainColor
        saveButton.tintColor = .white
        saveButton.cornerRadius = 10.0
        
        datePicker.contentHorizontalAlignment = .center
    }
    
    //MARK: - Delegate Func
    func didSelect(fuel: String) {
        changeFuelTypeButton.setTitle(fuel, for: .normal)
    }
    
    //MARK: - CoreData Load and Use
    private func loadData() {
        let udLastData = UserDefaults.standard
        pricePerLiterFuelTextField.text = "\(udLastData.string(forKey: "lastPrice") ?? "0")"
        changeFuelTypeButton.setTitle("\(udLastData.string(forKey: "lastFuelType") ?? "Не выбрано")",
                                      for: .normal)
        
        carMileageTextField.placeholder = mileage
    }
    
    //MARK: - TableView Fuel type
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeFuelType))
        tapGesture.numberOfTapsRequired = 1
        
        changeFuelTypeButton.addGestureRecognizer(tapGesture)
        changeFuelTypeButton.tintColor = .white
    }
    
    @objc private func changeFuelType() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let popVC = storyboard.instantiateViewController(
            withIdentifier: "popVC"
        ) as! TableViewController
        
        popVC.delegate = self
        popVC.modalPresentationStyle = .popover
        
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        
        popOverVC?.sourceView = self.changeFuelTypeButton
        popOverVC?.sourceRect = CGRect(x: self.changeFuelTypeButton.bounds.midX,
                                       y: self.changeFuelTypeButton.bounds.midY,
                                       width: 0,
                                       height: 0)
        
        popVC.preferredContentSize = CGSize(width: 250, height: 250)
        
        present(popVC,animated: true)
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
        
        guard pricePerLiterFuelTextField.hasText
        else {
            pricePerLiterFuelTextField.setWarningStyle()
            pricePerLiterFuelTextField.becomeFirstResponder()
            return false
        }
        pricePerLiterFuelTextField.setDefaultStyle()
        
        guard amountBYNTextField.hasText
        else {
            amountBYNTextField.setWarningStyle()
            amountBYNTextField.becomeFirstResponder()
            return false
        }
        amountBYNTextField.setDefaultStyle()
        
        guard fuelVolumeTextField.hasText
        else {
            fuelVolumeTextField.setWarningStyle()
            fuelVolumeTextField.becomeFirstResponder()
            return false
        }
        fuelVolumeTextField.setDefaultStyle()
        
        return true
    }
    
    //MARK: - Save Data Func
    private func saveData() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        let selectDate = datePicker.date
        
        let udLastData = UserDefaults.standard
        udLastData.set(pricePerLiterFuelTextField.text, forKey: "lastPrice")
        udLastData.set(changeFuelTypeButton.currentTitle, forKey: "lastFuelType")
        print(udLastData.string(forKey: "lastFuelType") ?? "Не выбрано")
        
        guard
            let mileage = Int32(carMileageTextField.text ?? ""),
            let fuelAmount = Double(amountBYNTextField.text ?? ""),
            let pricePerLiter = Double(pricePerLiterFuelTextField.text ?? ""),
            let fuelVolume = Double(fuelVolumeTextField.text ?? "")
        else { return }
        
        let request = CarMO.fetchRequest()
        let data = (try? CoreDataService.context.fetch(request)) ?? []
        
        let lastMileage = data.last?.mileage ?? 0
        let countMileage = mileage - lastMileage
        print(countMileage)
        
        let context = CoreDataService.context
        context.perform {
            let newFuel = CarMO(context: context)
            newFuel.mileage = mileage
            newFuel.generalPrice = fuelAmount
            newFuel.pricePerLiter = pricePerLiter
            newFuel.fuelVolume = fuelVolume
            newFuel.date = dateFormatter.string(from: selectDate)
            newFuel.fuelMileage = countMileage
            newFuel.category = "Заправка"
            CoreDataService.saveContext()
            print("fuelData saved")
        }
    }
    
    //MARK:  - IBActions
    @IBAction private func saveButtonDidTap() {
        
        if checkValidation() {
            saveData()
            navigationController?.popViewController(animated: true)
        }
    }
}


//MARK: - PopOver Delegate
extension FuelVC: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

//MARK: - UITextFieldDelegate
extension FuelVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let pricePerLiterDouble = Double(pricePerLiterFuelTextField.text ?? "") ?? 0.0
        let amountBYNDouble = Double(amountBYNTextField.text ?? "") ?? 0.0
        let fuelVolumeDouble = Double(fuelVolumeTextField.text ?? "") ?? 0.0
        
        if textField == amountBYNTextField,
           pricePerLiterFuelTextField.hasText
        {
            let sum: Double = amountBYNDouble / pricePerLiterDouble
            fuelVolumeTextField.text = "\(NSString(format: "%.2f", sum))"
        }
        
        if textField == fuelVolumeTextField,
           pricePerLiterFuelTextField.hasText
        {
            let sum: Double = fuelVolumeDouble * pricePerLiterDouble
            amountBYNTextField.text = "\(NSString(format: "%.2f", sum))"
        }
        
        return true
    }
}
