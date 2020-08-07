//
//  UserDetailsViewController.swift
//  ProductDelivery
//
//  Created by Penchal on 05/08/20.
//  Copyright © 2020 senix.com. All rights reserved.
//


import UIKit


class UserDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

  
    @IBOutlet weak var userDetailsTableView: UITableView!
    
    var responseData: UserDataModel?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataFromDatabase()
    }
    
        //MARK: Fetching data from local data base
        func fetchDataFromDatabase() {
            
            if let dataInfo = CoreDataHelper.fetchUserData() {
                self.responseData = dataInfo
                userDetailsTableView.reloadData()
            }else {
                print("Offline data not available For User")
            }
        }

    
    //MARK: TableView delegate and DataSource methods
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            guard responseData != nil  else {
                return 0
            }
            return 3
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier:tableCell) as! UserDetailsTableViewCell
            
            switch indexPath.row {
            case 0:
                cell.userDetailsLabel.text = "Customer Name : \(responseData?.customerName ?? "")"
            case 1:
                cell.userDetailsLabel.text = "Mobile No: \(responseData?.customerMobileNo ?? "")"
            case 2:
                cell.userDetailsLabel.text = "Address : \(responseData?.customerAddress ?? "")"
            default:
                print("default")
            }
            
            return cell
        }
        
    



}
