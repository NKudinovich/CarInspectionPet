//
//  StatisticVC.swift
//  Car Checklist
//
//  Created by Nikita Kudinovich on 20.09.23.
//

import UIKit

final class StatisticVC: UIViewController, UITableViewDataSource {
    
    @IBOutlet private weak var totalAmountLabel: UILabel!
    @IBOutlet private weak var totalAmountView: UIView!
    @IBOutlet private weak var totalAmountBYNLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    private var carData: [CarMO] = []
    private var sortedData: [CarMO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .mainColor
        tableView.setViewBorder(width: 1.0, color: .mainColor)
        tableView.cornerRadius = 5.0
        setupUIElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        loadTotalAmount()
        tableView.reloadData()
    }
    
    //MARK: - Setyup UI Elements
    private func setupUIElements() {
        totalAmountView.cornerRadius = 10.0
        totalAmountView.setViewBorder(width: 1.0, color: .mainColor)
        
        totalAmountLabel.text = "Всего потрачено, BYN"
        totalAmountLabel.textColor = .white
    }
    
    private func loadData() {
        let request = CarMO.fetchRequest()
        carData = (try? CoreDataService.context.fetch(request)) ?? []
        
        sortedData = carData.sorted {
            $0.mileage > $1.mileage
        }
    }
    
    private func loadTotalAmount() {
        let request = CarMO.fetchRequest()
        carData = (try? CoreDataService.context.fetch(request)) ?? []
        
        var totalAmountBYN: Double = 0
        
        carData.forEach {
            totalAmountBYN += $0.generalPrice
        }
        
       totalAmountBYNLabel.text = "\(NSString(format: "%.2f", totalAmountBYN))"
    }
}

extension StatisticVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "\(StatisticCell.self)", for: indexPath
        ) as! StatisticCell
        let textData = sortedData[indexPath.row]

        cell.date.text = textData.date
        cell.category.text = textData.category
        cell.price.text = "\(textData.generalPrice)"
        cell.mileage.text = "\(textData.mileage)км"
        if cell.category.text == "Сервис" {
            cell.openDescription.isHidden = false
        }
        return cell
    }
    
    private func openDescriptionVC(with carInfo: CarMO?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let descriptionVC = storyboard.instantiateViewController(
            withIdentifier: "\(DescriptionStaticCellVC.self)"
        ) as! DescriptionStaticCellVC
        
        descriptionVC.test = carInfo
        present(descriptionVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        
        openDescriptionVC(with: carData[indexPath.row])


    }
}
