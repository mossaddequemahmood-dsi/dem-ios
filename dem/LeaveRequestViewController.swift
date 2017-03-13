//
//  LeaveRequestViewController.swift
//  dem
//
//  Created by Mossaddeque Mahmood on 3/10/17.
//  Copyright © 2017 Dynamic Solution Innovators. All rights reserved.
//


import UIKit

import AVFoundation
import Foundation
import DropDown

class LeaveRequestViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    

    @IBOutlet weak var leaveRequestBtn: UIButton!
    @IBOutlet weak var txtLeaveType: UITextField!
    @IBOutlet weak var txtLeaveTypeDropdown: UITextField!
    
    let leaveTypes = ["Casual Leave Application", "Sick Leave Application"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pickerView = UIPickerView();
        pickerView.delegate = self;
        
        txtLeaveType?.inputView = pickerView;
        
        let dropDown = DropDown();
        dropDown.anchorView = txtLeaveTypeDropdown;
        dropDown.dataSource = ["Car", "Motorcycle", "Truck"];
        
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
    
    // Sets number of columns in picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Sets the number of rows in the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return leaveTypes.count
    }
    
    // This function sets the text of the picker view to the content of the "salutations" array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return leaveTypes[row]
    }
    
    // When user selects an option, this function will set the text of the text field to reflect the selected option.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtLeaveType.text = leaveTypes[row]
    }
}


