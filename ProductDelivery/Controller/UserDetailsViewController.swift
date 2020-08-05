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
    
    var responseData: UserDetails?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    
        //TableView delegate and DataSource methods
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 3
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier:tableCell) as! UserDetailsTableViewCell
            
            cell.userDetailsLabel.text = responseData?.order.customerName ?? "Name not availabel"
        
            return cell
        }
        
    



}
