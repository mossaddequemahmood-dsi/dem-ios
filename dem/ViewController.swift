//
//  ViewController.swift
//  dem
//
//  Created by Mossaddeque Mahmood on 2/16/17.
//  Copyright © 2017 Dynamic Solution Innovators. All rights reserved.
//

import UIKit

import AVFoundation
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var callInSickDayBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtUsername.text = "sean.king@example.com";
        txtPassword.text = "1234";
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func login(_ sender: UIButton) {
        
        if(txtUsername.text == "" || txtPassword.text == ""){
            lblMsg.text = "Username and Password can not be empty";
        }
        
        let userSessionService : UserSessionService = UserSessionService();

        userSessionService.login(username: txtUsername.text!, password: txtPassword.text!) {
                [weak self]status in
                
                self?.lblMsg.text = status.getStatusMessage();
                if(status.getStatus() == true){
                    self?.performSegue(withIdentifier: "showDashboard", sender: self);
                }
        }
    }

    
    @IBAction func callInSickDay(_ sender: UIButton) {
    }
}





















