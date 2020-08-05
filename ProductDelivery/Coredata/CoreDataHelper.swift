//
//  CoreDataHelper.swift
//  ProductDelivery
//
//  Created by Penchal on 05/08/20.
//  Copyright © 2020 senix.com. All rights reserved.
//
//

import Foundation


import CoreData
class CoreDataHelper {
    
   //MARK: - UserData DB Operations -
    
    class func saveDataAndUpdateData(userData:UserDataModel) {
        
        let userEntity:Customer!
        let aBatch = fetchUserDatails()
        
        if let batchObj = aBatch {
            userEntity = batchObj
        }
        else {
            userEntity = NSEntityDescription.insertNewObject(forEntityName: String(describing: Customer.self), into: context) as? Customer
        }
    
        userEntity.customerName     = userData.customerName
        userEntity.orderID          = userData.orderID
        userEntity.warehouseLat     = userData.warehouseLat
        userEntity.warehouseLng     = userData.warehouseLng
        userEntity.customerMobileNo = userData.customerMobileNo
        userEntity.customerLat      = userData.customerLat
        userEntity.customerLng      = userData.customerLng
        userEntity.paymentStatus    = userData.paymentStatus
        userEntity.deliveryMethod   = userData.deliveryMethod
        userEntity.warehouseAddress = userData.warehouseAddress
        userEntity.customerAddress  = userData.customerAddress
        userEntity.trackingID       = userData.trackingID
        userEntity.otp              = userData.otp
        
        
        do {
            try context.save()
            
        } catch let error {
            print("error occured while saving user data : \(error) ")
        }
    }
    
    //Checking if there are any duplicate Users data in DB
    class func fetchUserDatails() -> Customer? {
         
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Customer.self))
         do {
             let resultArray = try? context.fetch(fetchRequest)
            
              if let shiftObjs :[Customer] = resultArray as? [Customer] , shiftObjs.count > 0 {
                 if shiftObjs.count > 0 {
                   return shiftObjs[0]
                 }
                 return nil
             }
         }
        return  nil
     }
    
    //Fetching Data from DB
    class func fetchUserData() -> UserDataModel? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Customer.self))
        do {
            guard let data = try context.fetch(fetchRequest) as? [Customer] else { return nil }
            
            for dataInfo in data {
                    var userData                = UserDataModel()
                userData.customerName           = dataInfo.customerName
                userData.orderID                = dataInfo.orderID
                userData.warehouseLat           = dataInfo.warehouseLat
                userData.warehouseLng           = dataInfo.warehouseLng
                userData.customerMobileNo       = dataInfo.customerMobileNo
                userData.customerLat            = dataInfo.customerLat
                userData.customerLng            = dataInfo.customerLng
                userData.paymentStatus          = dataInfo.paymentStatus
                userData.deliveryMethod         = dataInfo.deliveryMethod
                userData.warehouseAddress       = dataInfo.warehouseAddress
                userData.customerAddress        = dataInfo.customerAddress
                userData.trackingID             = dataInfo.trackingID
                userData.otp                    = dataInfo.otp
                
                return userData
                
            }
            return nil
        }
        catch let error {
            print("error occured while fetching user data : \(error)")
            return nil
        }
    }
    
    //Delete data from DB
    class func deleteAllUserData() {
         
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Customer.self))
         let deleteBatchRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
         
         do {
             try context.execute(deleteBatchRequest)
             try context.save()
         }
         catch let error {
             print(error)
         }
     }
}

 
