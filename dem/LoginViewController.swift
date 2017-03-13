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

class LoginViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        txtUsername?.text = "sean.king@example.com";
        txtPassword?.text = "1234";
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
                    self?.performSegue(withIdentifier: "segueShowDashboard", sender: self);
                }
        }
    }

    

}





















