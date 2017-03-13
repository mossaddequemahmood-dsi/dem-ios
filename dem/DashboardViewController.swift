//
//  DashboardViewController.swift
//  dem
//
//  Created by Mossaddeque Mahmood on 3/10/17.
//  Copyright © 2017 Dynamic Solution Innovators. All rights reserved.
//

import Foundation
import UIKit

import AVFoundation

class DashboardViewController: UIViewController {
    
    
    @IBOutlet weak var leaveRequestBtn: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func leaveRequest(_ sender: UIButton) {
        
        print("Hello!!!")
        performSegue(withIdentifier: "segueShowLeaveRequestForm", sender: self);
    }

}
