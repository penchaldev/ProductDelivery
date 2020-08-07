//
//  ViewController.swift
//  ProductDelivery
//
//  Created by Penchal on 05/08/20.
//  Copyright © 2020 senix.com. All rights reserved.
//


import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    var userDetailsResponse:UserDetails?
    
    let locationManager = CLLocationManager()
    
    var warehouseLatValue = CLLocationDegrees()
    var warehouseLongValue = CLLocationDegrees()
    
    let destinationMarker = GMSMarker()
    let currentLoactionMarker = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
          
          mapView.isMyLocationEnabled = true
          mapView.settings.myLocationButton = true
          locationManager.startUpdatingLocation()
            
        } else {
          locationManager.requestWhenInUseAuthorization()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if Reachability.isConnectedToNetwork() {
            serverCalls()
        }
    }

    //MARK: Making network call to fetch data from API
    
    func serverCalls() {
        
        showActivityIndicator(progressLabel: "Fetching Data")
        PDNetworkManager.getServiceCall() { (userObject) in
            self.userDetailsResponse = userObject
            self.hideActivityIndicator()
            self.saveAndUpdateUserDetails()
            self.fetchDataFromDatabase()
        }
        
    }
    
    //MARK: Save and updating data into coredata
    func saveAndUpdateUserDetails() {
        
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
    
    //MARK: Fetching data from local data base
    
    func fetchDataFromDatabase() {
        
        if let dataInfo = CoreDataHelper.fetchUserData() {
            
            let currentLattitute = Double(dataInfo.customerLat!)
            let currentLongitude = Double(dataInfo.customerLng!)
            
            let destinationLatitude = Double(dataInfo.warehouseLat!)
            let destinationLogintude = Double(dataInfo.warehouseLng!)
            
            let fromLoc = CLLocationCoordinate2DMake(currentLattitute!, currentLongitude!)
            let toLoc = CLLocationCoordinate2DMake(destinationLatitude!, destinationLogintude!)
                        
//            let fromLoc = CLLocationCoordinate2DMake(12.985330, 80.120338)
//            let toLoc = CLLocationCoordinate2DMake(12.922915, 80.127457)

               drawPolylineOnMap(src: fromLoc, dst: toLoc)
        }
    }

    //MARK: Navigating to second View Controller
    
    @IBAction func displayUserDetails(_ sender: Any) {
        let userDetailsController = storyboard?.instantiateViewController(identifier: keyUserDetailsVC) as! UserDetailsViewController
        self.navigationController?.pushViewController(userDetailsController, animated: true)
        
    }
    
    //MARK: Draw Polyline
    
    func drawPolylineOnMap (src: CLLocationCoordinate2D, dst: CLLocationCoordinate2D) {

        let str = String(format:"https://maps.googleapis.com/maps/api/directions/json?origin=\(src.latitude),\(src.longitude)&destination=\(dst.latitude),\(dst.longitude)&key=AIzaSyBRy4KKlz1e6C_gKO7AR-VlY5ou7qjrTdE")

        Alamofire.request(str).responseJSON { (responseObject) -> Void in

            let resJson = JSON(responseObject.result)
            print(responseObject)
            //We are Getting Error here:  "error_message" = "This API project is not authorized to use this API."
            self.showAlert(message: "This API project is not authorized to use this API.", title: "PolylineOnMap")
            return
            
            
            if(resJson["status"].rawString()! == "ZERO_RESULTS")
            {
                print("maps directions zero results")
            }
            else if(resJson["status"].rawString()! == "NOT_FOUND")
            {
              print("maps directions data not found")
            }
            else{
                
                let routes : NSArray = resJson["routes"].rawValue as! NSArray
                print(routes)

                let position = CLLocationCoordinate2D(latitude: src.latitude, longitude: src.longitude)

                let marker = GMSMarker(position: position)
                marker.icon = UIImage(named: "mapCurrent")
                marker.title = "Customer have selected same location as yours"
                marker.map = self.mapView

                let position2 = CLLocationCoordinate2D(latitude: dst.latitude, longitude: dst.longitude)

                let marker1 = GMSMarker(position: position2)
                marker1.icon = UIImage(named: "makeupmarker")
                marker1.title = "aa"
                marker1.map = self.mapView

                let pathv : NSArray = routes.value(forKey: "overview_polyline") as! NSArray
                print(pathv)
                let paths : NSArray = pathv.value(forKey: "points") as! NSArray
                print(paths)
                let newPath = GMSPath.init(fromEncodedPath: paths[0] as! String)


                let polyLine = GMSPolyline(path: newPath)
                polyLine.strokeWidth = 3
                polyLine.strokeColor = UIColor.blue
                polyLine.map = self.mapView

                let bounds = GMSCoordinateBounds(coordinate: position, coordinate: position2)
                let update = GMSCameraUpdate.fit(bounds, with: UIEdgeInsets(top: 170, left: 30, bottom: 30, right: 30))
                self.mapView!.moveCamera(update)

            }
        }
    }
}

//MARK: CLLocationManagerDelegate Methods

extension ViewController {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
      
        guard status == .authorizedWhenInUse else { return }
        
        //locationManager.requestLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
      guard let location = locations.first else {
        return
      }
        //let location = locations.last

        let camera = GMSCameraPosition.camera(withLatitude: (location.coordinate.latitude), longitude: (location.coordinate.longitude), zoom: 6.0)

        self.mapView?.animate(to: camera)

        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
        
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      print(error)
    }
}

