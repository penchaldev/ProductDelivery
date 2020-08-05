//
//  Customer+CoreDataProperties.swift
//  ProductDelivery
//
//  Created by Penchal on 05/08/20.
//  Copyright © 2020 senix.com. All rights reserved.
//
//

import Foundation
import CoreData


extension Customer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer")
    }

    @NSManaged public var customerName: String?
    @NSManaged public var customerMobileNo: String?
    @NSManaged public var customerLat: String?
    @NSManaged public var customerLng: String?
    @NSManaged public var warehouseLat: String?
    @NSManaged public var warehouseLng: String?
    @NSManaged public var orderID: String?
    @NSManaged public var paymentStatus: String?
    @NSManaged public var deliveryMethod: String?
    @NSManaged public var warehouseAddress: String?
    @NSManaged public var customerAddress: String?
    @NSManaged public var trackingID: String?
    @NSManaged public var otp: String?

}
