//
//  UserDetailsModel.swift
//  ProductDelivery
//
//  Created by Penchal on 05/08/20.
//  Copyright © 2020 senix.com. All rights reserved.
//


import Foundation

// MARK: - UserDetails
struct UserDetails: Codable {
    let message: String
    let requestID: Int
    let order: Order

    enum CodingKeys: String, CodingKey {
        case message
        case requestID = "request_id"
        case order
    }
}

// MARK: - Order
struct Order: Codable {
    let orderID, deliveryTo, warehouseLat, warehouseLng: String
    let customerName, customerMobile, customerLat, customerLng: String
    let productName, productQty, productWeight, paymentStatus: String
    let deliveryMethod, warehouseAddress, customerAddress, productWidth: String
    let productHeight: String
    let serviceType, trackingID, otp: Int
    let status: String
    let userID, currentProviderID, id: Int

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case deliveryTo = "delivery_to"
        case warehouseLat = "warehouse_lat"
        case warehouseLng = "warehouse_lng"
        case customerName = "customer_name"
        case customerMobile = "customer_mobile"
        case customerLat = "customer_lat"
        case customerLng = "customer_lng"
        case productName = "product_name"
        case productQty = "product_qty"
        case productWeight = "product_weight"
        case paymentStatus = "payment_status"
        case deliveryMethod = "delivery_method"
        case warehouseAddress = "warehouse_address"
        case customerAddress = "customer_address"
        case productWidth = "product_width"
        case productHeight = "product_height"
        case serviceType = "service_type"
        case trackingID = "tracking_id"
        case otp, status
        case userID = "user_id"
        case currentProviderID = "current_provider_id"
        case id
    }
}

//MARK: - CoreData Model

struct UserDataModel {
    
    var customerName:String?
    var orderID:String?
    var warehouseLat:String?
    var warehouseLng:String?
    var customerMobileNo:String?
    var customerLat:String?
    var customerLng:String?
    var paymentStatus:String?
    var deliveryMethod:String?
    var warehouseAddress:String?
    var customerAddress:String?
    var trackingID:String?
    var otp:String?
}
