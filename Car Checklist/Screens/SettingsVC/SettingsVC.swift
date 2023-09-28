//
//  SettingsVC.swift
//  Car Checklist
//
//  Created by Nikita Kudinovich on 18.09.23.
//

import UIKit

final class SettingsVC: UIViewController {
    @IBOutlet private weak var nameSettingsView: UIView!
    @IBOutlet private weak var nameSettingsLabel: UILabel!
    @IBOutlet private weak var nameSettingsTextField: UITextField!
    
    @IBOutlet private weak var carMileageSettingsView: UIView!
    @IBOutlet private weak var carMileageSettingsLabel: UILabel!
    @IBOutlet private weak var carMileageSettingsTextField: UITextField!
    
    @IBOutlet private weak var saveButton: UIButton!
    
    var delegate: MainVC?
    var model: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUIElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadInfo()
        nameSettingsTextField.text = model
    }
    
    
    
    //MARK: - Setup UI Elements
    private func setupUIElements() {
        view.backgroundColor = .mainBackground
        
        nameSettingsView.cornerRadius = 10.0
        nameSettingsView.setViewBorder(width: 1.0, color: .mainColor)
        nameSettingsView.backgroundColor = .mainBackground
        nameSettingsTextField.backgroundColor = .mainBackground
        
        carMileageSettingsView.cornerRadius = 10.0
        carMileageSettingsView.setViewBorder(width: 1.0, color: .mainColor)
        carMileageSettingsView.backgroundColor = .mainBackground
        carMileageSettingsTextField.backgroundColor = .mainBackground
        
        nameSettingsLabel.text = "Название авто"
        nameSettingsLabel.textColor = .white
        
        carMileageSettingsLabel.text = "Пробег, км"
        carMileageSettingsLabel.textColor = .white
        
        nameSettingsTextField.backgroundColor = .mainBackground
        carMileageSettingsTextField.backgroundColor = .mainBackground
        
        
        saveButton.cornerRadius = 10.0
        saveButton.backgroundColor = .mainColor
        saveButton.tintColor = .white
    }
    
    //MARK: - CoreData Load
    private func loadInfo() {
        let request = CarMO.fetchRequest()
        let data = (try? CoreDataService.context.fetch(request)) ?? []
    
        carMileageSettingsTextField.text = "\(data.last?.mileage ?? 0)"
    }
    
    //MARK: - Save Data
    private func saveData() {
        guard let mileage = Int32(carMileageSettingsTextField.text ?? "")
        else { return }
        
        let context = CoreDataService.context
        context.perform {
            let newSettings = CarMO(context: context)
            newSettings.mileage = mileage
            newSettings.category = "Изменение модели"
            CoreDataService.saveContext()
            print("Settings saved")
        }
    }
    
    @IBAction func saveButtonDidTap() {
        saveData()
        let udModel = UserDefaults.standard
        udModel.set(nameSettingsTextField.text, forKey: "model")
        navigationController?.popViewController(animated: true)
    }
}
