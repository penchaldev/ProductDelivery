//
//  ViewController.swift
//  ProductDelivery
//
//  Created by Penchal on 05/08/20.
//  Copyright © 2020 senix.com. All rights reserved.
//


import UIKit

class ViewController: UIViewController {

    var userDetailsResponse:UserDetails?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if Reachability.isConnectedToNetwork() {
            serverCalls()
        }else {
           fetchDataFromDatabase()
        }
    }
    
    func serverCalls() {
        showActivityIndicator(progressLabel: "Fetching Data")
        PDNetworkManager.getServiceCall() { (userObject) in
            self.userDetailsResponse = userObject
//            print("API Fetched User Details: \(String(describing: self.userDetailsResponse))")
            self.hideActivityIndicator()
            self.displayWeatherReport()
        }
        fetchDataFromDatabase()
        
    }
    func displayWeatherReport() {
        DispatchQueue.main.async {
            
            var userModel = UserDataModel()
            userModel.customerName     = self.userDetailsResponse?.order.customerName
            userModel.orderID          = self.userDetailsResponse?.order.orderID
            userModel.warehouseLng     = self.userDetailsResponse?.order.warehouseLng
            userModel.warehouseLat     = self.userDetailsResponse?.order.warehouseLat
            userModel.customerMobileNo = self.userDetailsResponse?.order.customerMobile
            userModel.customerLng      = self.userDetailsResponse?.order.customerLng
            userModel.customerLat      = self.userDetailsResponse?.order.customerLat
            userModel.paymentStatus    = self.userDetailsResponse?.order.paymentStatus
            userModel.deliveryMethod   = self.userDetailsResponse?.order.deliveryMethod
            userModel.warehouseAddress = self.userDetailsResponse?.order.warehouseAddress
            userModel.customerAddress  = self.userDetailsResponse?.order.customerAddress
            if let responseOtp = self.userDetailsResponse?.order.otp{
                userModel.otp = "\(responseOtp)"
            }
            if let responseTrackingID = self.userDetailsResponse?.order.otp{
                userModel.trackingID = "\(responseTrackingID)"
            }
            CoreDataHelper.saveDataAndUpdateData(userData: userModel)
        }
    }
    
    func fetchDataFromDatabase() {
        
        if let dataInfo = CoreDataHelper.fetchUserData() {
            
//            print("offlineData:\(dataInfo)")
            print("Customer Name: \(dataInfo.customerName ?? "")")
            print("Customer Mobile Number: \(dataInfo.customerMobileNo ?? "")")
            print("Customer Address: \(dataInfo.customerAddress ?? "")")
            print("Customer Longitude: \(dataInfo.customerLng ?? "")")
            print("Customer Latitude: \(dataInfo.customerLat ?? "")")
            
            
        }else {
            print("Offline data not available For User")
        }
        
    }
    
    
}

