//
//  CoreDataHelper.swift
//  WeatherReport
//
//  Created by Penchal on 30/07/20.
//  Copyright © 2020 senix.com. All rights reserved.
//

import Foundation

/*
import CoreData
class CoreDataHelper {
    
   //MARK: - UserData DB Operations -
    
    class func saveDataAndUpdateData(userData:WeatherDataModel) {
        
        let whetherInfoEntity:WeatherData!
        let aBatch = fetchWhetherLocationData(location: userData.location!)
        
        if let batchObj = aBatch {
            whetherInfoEntity = batchObj
        }
        else {
            whetherInfoEntity = NSEntityDescription.insertNewObject(forEntityName: String(describing: WeatherData.self), into: context) as? WeatherData
        }
    
        whetherInfoEntity.location           = userData.location
        whetherInfoEntity.temperature        = userData.temperature
        whetherInfoEntity.weather            = userData.weather
        whetherInfoEntity.weatherDescription = userData.weatherDescription
        whetherInfoEntity.windSpeed          = userData.windSpeed
        whetherInfoEntity.humidity           = userData.humidity
        whetherInfoEntity.icon               = userData.icon
  
        
        do {
            try context.save()
            
        } catch let error {
            print("error occured while saving user data : \(error) ")
        }
    }
    
    //Checking if there are any duplicate locations in DB
    class func fetchWhetherLocationData(location:String) -> WeatherData? {
         

         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: WeatherData.self))
         fetchRequest.predicate = NSPredicate(format: "location == %@", location)

         do {
             let resultArray = try? context.fetch(fetchRequest)
            
              if let shiftObjs :[WeatherData] = resultArray as? [WeatherData] , shiftObjs.count > 0 {
                 if shiftObjs.count > 0 {
                   return shiftObjs[0]
                 }
                 return nil
             }
         }
        return  nil
     }
    
    //Fetching Data from DB
    class func fetchWhetherData(location:String) -> WeatherDataModel? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: WeatherData.self))
        do {
            guard let data = try context.fetch(fetchRequest) as? [WeatherData] else { return nil }
            
             for dataInfo in data {
                if dataInfo.location == location {
                    var whetherData                = WeatherDataModel()
                    whetherData.location           = dataInfo.location
                    whetherData.temperature        = dataInfo.temperature
                    whetherData.weather            = dataInfo.weather
                    whetherData.weatherDescription = dataInfo.weatherDescription
                    whetherData.windSpeed          = dataInfo.windSpeed
                    whetherData.humidity           = dataInfo.humidity
                    whetherData.icon               = dataInfo.icon
                    return whetherData
                }
            }
            return nil
        }
        catch let error {
            print("error occured while fetching user data : \(error)")
            return nil
        }
    }
    
    //Delete data from DB
    class func deleteAllWhetherData() {
         
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: WeatherData.self))
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

 
*/
