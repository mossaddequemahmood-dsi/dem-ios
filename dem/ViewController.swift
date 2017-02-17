//
//  ViewController.swift
//  dem
//
//  Created by sazzad on 2/16/17.
//  Copyright © 2017 Dynamic Solution Innovators. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func login(_ sender: UIButton) {
        
        txtUsername.text = "sean.king@example.com";
        txtPassword.text = "1234";
        
        let path : String = Bundle.main.path(forResource: "app", ofType: "plist")!;
        let dict = NSDictionary(contentsOfFile: path);
        
        if let tetant : String = dict!.object(forKey: "AuthTenantID") as? String {
            print(tetant);
            lblMsg.text = tetant;
        }
        

        
        if(txtUsername.text == "" || txtPassword.text == ""){
            lblMsg.text = "Username and Password can not be empty";
        }
        //print(txtUsername);
        //print(txtPassword);
        
        /*Alamofire.request("https://httpbin.org/get").responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }*/
    }

}

