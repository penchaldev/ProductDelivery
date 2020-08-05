//
//  ViewController.swift
//  ProductDelivery
//
//  Created by Penchal on 05/08/20.
//  Copyright © 2020 senix.com. All rights reserved.
//


import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getUserDetails()
    }
    
    func getUserDetails(){
        WRNetworkManager.getServiceCall { (userResponse) in
            print(userResponse)
        }
    }
    
}

