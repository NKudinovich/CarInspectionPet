//
//  CarMO+CoreDataProperties.swift
//  Car Checklist
//
//  Created by Nikita Kudinovich on 21.09.23.
//
//

import Foundation
import CoreData


extension CarMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarMO> {
        return NSFetchRequest<CarMO>(entityName: "CarMO")
    }

    @NSManaged public var category: String?
    @NSManaged public var date: String?
    @NSManaged public var fuelAmount: Double
    @NSManaged public var fuelVolume: Double
    @NSManaged public var generalPrice: Double
    @NSManaged public var mileage: Int32
    @NSManaged public var pricePerLiter: Double
    @NSManaged public var serviceDescription: String?
    @NSManaged public var fuelMileage: Int32

}

extension CarMO : Identifiable {

}
