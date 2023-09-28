//
//  TableViewController.swift
//  Car Checklist
//
//  Created by Nikita Kudinovich on 19.09.23.
//

import UIKit

class TableViewController: UITableViewController {

    var delegate: FuelVCProtocole?
    
    let fuelTypes = ["АИ-92",
                     "АИ-95",
                     "АИ-98",
                     "ДТ"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.isScrollEnabled = false
        
        tableView.separatorColor = .mainColor
    }

    override func viewWillLayoutSubviews() {
        preferredContentSize = CGSize(width: 250, height: tableView.contentSize.height)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fuelTypes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Cell
        let fuelTypes = fuelTypes[indexPath.row]
        cell.fuelTypeLabel.text = fuelTypes
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.didSelect(fuel: fuelTypes[indexPath.row])
        
        print(fuelTypes[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        
        dismiss(animated: true)
    }
}
