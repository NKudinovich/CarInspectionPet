//
//  MainVC.swift
//  Car Checklist
//
//  Created by Nikita Kudinovich on 18.09.23.
//

import UIKit


final class MainVC: UIViewController {
    
    //Outlet's views
    @IBOutlet private weak var fuelView: UIView!
    @IBOutlet private weak var oilChangeView: UIView!
    @IBOutlet private weak var carInfoView: UIView!
    
    //Outlet's labels
    @IBOutlet private weak var fuelLabel: UILabel!
    @IBOutlet private weak var averageFuelLabel: UILabel!
    @IBOutlet private weak var oilChangeLabel: UILabel!
    @IBOutlet private weak var oilCountChangeLabel: UILabel!
    @IBOutlet private weak var fuelLabelUnderFuelButton: UILabel!
    @IBOutlet private weak var parkingLabelUnderParkButton: UILabel!
    @IBOutlet private weak var carWashingLabelUnderWashButton: UILabel!
    @IBOutlet private weak var serviceLabelUnderServiceButton: UILabel!
    
    //Label's in carInfo view
    @IBOutlet private weak var carModel: UILabel!
    @IBOutlet private weak var carMileage: UILabel!
    @IBOutlet private weak var costKilometer: UILabel!
    
    //Outlet's image views
    @IBOutlet private weak var carImageView: UIImageView!
    
    //Outlet's buttons
    @IBOutlet private weak var addFuelButton: UIButton!
    @IBOutlet private weak var addParkButton: UIButton!
    @IBOutlet private weak var addCarWashingButton: UIButton!
    @IBOutlet private weak var addServiceButton: UIButton!
    @IBOutlet private weak var statisticButton: UIButton!
       
    private var carData: [CarMO] = []
    private var sortedData: [CarMO] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setupUIElements()
        
        //Top status Bar and navigation bar settings
        setBarMode()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
        averageFuelLabel.text = "\(NSString(format: "%.2f", averageConsumption()))/100км"
        
        costKilometer.text = "\(NSString(format: "%.2f", totalSummBYN()))р/100км"
    }
    
    //MARK: - Setup UI Elements
    private func setupUIElements() {
        //Set main view background
        self.view.backgroundColor = UIColor.mainBackground
        
        //Set fuel view and label style
        fuelView.cornerRadius = 10.0
        fuelView.backgroundColor = UIColor.mainColor
        fuelView.setViewBorder(width: 1.0,
                               color: UIColor.lightOrange)
        
        fuelLabel.text = "Расход топлива"
        
        fuelLabelUnderFuelButton.text = "Заправка"
        fuelLabelUnderFuelButton.setLabelStyle()
        
        //Set oil view and label style
        oilChangeView.cornerRadius = 10.0
        oilChangeView.backgroundColor = UIColor.mainColor
        oilChangeView.setViewBorder(width: 1.0,
                                    color: UIColor.lightOrange)
        oilChangeLabel.text = "Замена масла через"
        oilCountChangeLabel.text = "7000km"
        
        //Set labels
        parkingLabelUnderParkButton.text = "Парковка"
        parkingLabelUnderParkButton.setLabelStyle()
        
        carWashingLabelUnderWashButton.text = "Мойка"
        carWashingLabelUnderWashButton.setLabelStyle()
        
        serviceLabelUnderServiceButton.text = "Ремонт"
        serviceLabelUnderServiceButton.setLabelStyle()
        
        
        //Set carInfo view and labels
        carInfoView.cornerRadius = 10.0
        carInfoView.setViewBorder(width: 1.0, color: UIColor.lightOrange)
    
        carModel.textColor = .white
        
        costKilometer.textColor = .white
        
        carMileage.textColor = .white
        
        //Set buttons
        addFuelButton.cornerRadius = addFuelButton.frame.height / 2
        addFuelButton.setViewBorder(width: 1.0, color: UIColor.lightOrange)
        addFuelButton.backgroundColor = UIColor.mainColor
        
        addParkButton.cornerRadius = addParkButton.frame.height / 2
        addParkButton.setViewBorder(width: 1.0, color: UIColor.lightOrange)
        addParkButton.backgroundColor = UIColor.mainColor
        
        addCarWashingButton.cornerRadius = addCarWashingButton.frame.height / 2
        addCarWashingButton.setViewBorder(width: 1.0, color: UIColor.lightOrange)
        addCarWashingButton.backgroundColor = UIColor.mainColor
        
        addServiceButton.cornerRadius = addServiceButton.frame.height / 2
        addServiceButton.setViewBorder(width: 1.0, color: UIColor.lightOrange)
        addServiceButton.backgroundColor = UIColor.mainColor

        statisticButton.cornerRadius = 10.0
        statisticButton.setViewBorder(width: 1.0, color: .mainColor)
    }
    
    //MARK: - CoreData Load and Use
    private func loadData() {
        let request = CarMO.fetchRequest()
        let data = (try? CoreDataService.context.fetch(request)) ?? []
        sortedData = data.sorted {
            $0.mileage < $1.mileage
        }
        carMileage.text = "\(sortedData.last?.mileage ?? 0)км"
        let udModel = UserDefaults.standard
        carModel.text = "\(udModel.string(forKey: "model") ?? "Unknown")"
    }
    
    //MARK: - Get Min and Max Mileage
    private func getMinMaxMileage() -> Int32 {
        let request = CarMO.fetchRequest()
        let data = (try? CoreDataService.context.fetch(request))
        
        var totalFuelMileage: Int32 = 0
        
        data?.forEach {
            totalFuelMileage += $0.fuelMileage
        }
        print(totalFuelMileage)
        return totalFuelMileage
    }
    
    //MARK: - Get Total Fuel Amount
    private func totalFuelVolume() -> Double {
        let request = CarMO.fetchRequest()
        let data = (try? CoreDataService.context.fetch(request)) ?? []
        
        var totalFuelVolume: Double = 0
        
        data.forEach {
            totalFuelVolume += $0.fuelVolume
        }
        print("Total fuel volume \(totalFuelVolume)")
        return Double(totalFuelVolume)
    }
    
    //MARK: - Total BYN
    private func totalPrice() -> Double{
        let request = CarMO.fetchRequest()
        let data = (try? CoreDataService.context.fetch(request)) ?? []
        
        var totalBYNSum: Double = 0
        data.forEach {
            totalBYNSum += $0.generalPrice
        }
        print("Price \(totalBYNSum)")
        return Double(totalBYNSum)
    }
    
    //MARK: - Calculate Total Sum BYN
    private func totalSummBYN() -> Double{
        var totalSummBYN: Double = 0
        
        var averageMileage = getMinMaxMileage()
        var totalSum = totalPrice()
        
        totalSummBYN = Double(averageMileage) / totalSum
        
        return Double(totalSummBYN)
    }
    
    //MARK: - Calculate Fuel Average Consumption
    private func averageConsumption() -> Double {
        var averageFuelConsumption: Double = 0
        
        var averageMileage = getMinMaxMileage()
        var totalFuelAmount = totalFuelVolume()
        
        averageFuelConsumption = Double(averageMileage) / totalFuelAmount
        
        return Double(averageFuelConsumption)
    }
    
    //MARK: - Setup Bar Button
    private func setBarMode() {
        let settingsBarButton = UIBarButtonItem(image: UIImage(systemName: "gearshape"),
                                                style: .plain,
                                                target: self,
                                                action: #selector(settingsBarButtonDidTap))
        navigationItem.leftBarButtonItem = settingsBarButton
        navigationController?.navigationBar.tintColor = .mainColor
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.mainColor
        ]
    }
    
    @objc func settingsBarButtonDidTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsVC = storyboard.instantiateViewController(
            withIdentifier: "SettingsVC"
        ) as! SettingsVC
        
        settingsVC.delegate = self
        settingsVC.model = carModel.text
        navigationController?.pushViewController(settingsVC, animated: true)
    }

    //MARK: - IBActions
    @IBAction private func addFuelButtonDidTap(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let fuelVC = storyboard.instantiateViewController(
            withIdentifier: "FuelVC"
        ) as! FuelVC
        
        fuelVC.delegate = self
        fuelVC.mileage = carMileage.text
        navigationController?.pushViewController(fuelVC, animated: true)
    }

    @IBAction private func addParkingButtonDidTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let parkingVC = storyboard.instantiateViewController(
            withIdentifier: "ParkingVC"
        ) as! ParkingVC
        
        parkingVC.delegate = self
        parkingVC.mileage = carMileage.text
        navigationController?.pushViewController(parkingVC, animated: true)
    }

    @IBAction private func addWashingButtonDidTap(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let carWashingVC = storyboard.instantiateViewController(
            withIdentifier: "CarWashingVC"
        ) as! CarWashingVC
        
        carWashingVC.delegate = self
        carWashingVC.mileage = carMileage.text
        
        navigationController?.pushViewController(carWashingVC, animated: true)
    }
    
    @IBAction private func addServiceButtonDidTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let serviceVC = storyboard.instantiateViewController(
            withIdentifier: "\(ServiceVC.self)"
        ) as! ServiceVC
        
        serviceVC.delegate = self
        serviceVC.mileage = carMileage.text
        navigationController?.pushViewController(serviceVC, animated: true)
    }
    
    @IBAction private func statisticButtonDidTap() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let statisticVC = storyboard.instantiateViewController(
            withIdentifier: "\(StatisticVC.self)"
        ) as! StatisticVC
        navigationController?.pushViewController(statisticVC, animated: true)
    }
}
