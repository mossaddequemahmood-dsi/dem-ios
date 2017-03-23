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

class LeaveRequestViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate {
    
    let dateFormatter = DateFormatter()
    
    @IBOutlet weak var txtLeaveType: UITextField!
    @IBOutlet weak var txtStartDate: UITextField!
    @IBOutlet weak var txtEndDate: UITextField!
    @IBOutlet weak var txtViewReason: UITextView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    
    static let casualLeaveApplication : String = "Casual Leave Application";
    static let sickLeaveApplication : String = "Sick Leave Application";
    
    let leaveTypes = [casualLeaveApplication, sickLeaveApplication];
    
    let reasonPlaceholderText : String = "Write up the reason!";
    

    override func viewDidLoad() {
        
        super.viewDidLoad();
        
        let pickerView = UIPickerView();
        pickerView.delegate = self;
        txtLeaveType?.inputView = pickerView;
        
        dateFormatter.dateStyle = DateFormatter.Style.medium;
        dateFormatter.timeStyle = DateFormatter.Style.none;
        
        txtViewReason.delegate = self;
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        initData();
    }
    
    func initData() {
        
        txtLeaveType.text = LeaveRequestViewController.sickLeaveApplication;
        txtStartDate.text = dateFormatter.string(from: Date());
        txtEndDate.text = dateFormatter.string(from: Date());
        txtViewReason.text = reasonPlaceholderText;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func submitLeaveRequest(_ sender: UIButton) {
        
        lblMessage.text = "";
        
        let isValidated = validate();
        
        if isValidated == true {
            
            let leaveService : LeaveService = LeaveService();
            
            leaveService.postLeaveRequest(leaveType: txtLeaveType.text!, startDateStr: txtStartDate.text!, endDateStr: txtEndDate.text!, reason: txtViewReason.text!) {
                [weak self]status in
                
                if status.getStatus() == true {
                    
                    let alert = UIAlertController(title: "Status", message: "Succesfully submitted.", preferredStyle: UIAlertControllerStyle.alert);
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            self?.performSegue(withIdentifier: "segueBackToDashboard", sender: self);
                        case .cancel:
                            self?.performSegue(withIdentifier: "segueBackToDashboard", sender: self);
                        case .destructive:
                            self?.performSegue(withIdentifier: "segueBackToDashboard", sender: self);
                        }
                    }));
                    
                    self?.present(alert, animated: true, completion: nil);
                } else {
                    self?.lblMessage.text = status.getStatusMessage();
                }

            }
            
            
        }
        

        
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "segueBackToDashboard", sender: self);
    }
    
    func validate() -> Bool {
        
        var isValid : Bool = true;
        
        let whitespace = CharacterSet.whitespaces;
        
        if(txtLeaveType.text?.trimmingCharacters(in: whitespace) == ""){
            errorHighlightTextField(textField: txtLeaveType);
            isValid = false;
        } else{
            removeErrorHighlightTextField(textField: txtLeaveType);
        }
        
        if(txtStartDate.text?.trimmingCharacters(in: whitespace) == ""){
            errorHighlightTextField(textField: txtStartDate);
            isValid = false;
        } else{
            removeErrorHighlightTextField(textField: txtStartDate);
        }
        
        if(txtEndDate.text?.trimmingCharacters(in: whitespace) == ""){
            errorHighlightTextField(textField: txtEndDate);
            isValid = false;
        } else{
            removeErrorHighlightTextField(textField: txtEndDate);
        }
        
        if(txtViewReason.text?.trimmingCharacters(in: whitespace) == ""){
            errorHighlightTextView(textView: txtViewReason);
            isValid = false;
        } else{
            removeErrorHighlightTextView(textView: txtViewReason);
        }
        
        if(txtViewReason.text == reasonPlaceholderText){
            errorHighlightTextView(textView: txtViewReason);
            isValid = false;
        } else{
            removeErrorHighlightTextView(textView: txtViewReason);
        }
        
        return isValid;
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        txtViewReason.text = "";
        txtViewReason.textColor = UIColor.black;
    }
    
    // Text Field is empty - show red border
    func errorHighlightTextField(textField: UITextField){
        textField.layer.borderColor = UIColor.red.cgColor;
        textField.layer.borderWidth = 1;
        textField.layer.cornerRadius = 5;
    }
    
    // Text Field is NOT empty - show gray border with 0 border width
    func removeErrorHighlightTextField(textField: UITextField){
        textField.layer.borderColor = UIColor.gray.cgColor;
        textField.layer.borderWidth = 0;
        textField.layer.cornerRadius = 5;
    }
    
    // Text View is empty - show red border
    func errorHighlightTextView(textView: UITextView){
        textView.layer.borderColor = UIColor.red.cgColor;
        textView.layer.borderWidth = 1;
        textView.layer.cornerRadius = 5;
    }
    
    // Text View is NOT empty - show gray border with 0 border width
    func removeErrorHighlightTextView(textView: UITextView){
        textView.layer.borderColor = UIColor.gray.cgColor;
        textView.layer.borderWidth = 0;
        textView.layer.cornerRadius = 5;
    }
    
    @IBAction func startDateEditingBegin(_ sender: UITextField) {
        
        let startDateDatePicker = UIDatePicker();
        startDateDatePicker.datePickerMode = UIDatePickerMode.date;
        sender.inputView = startDateDatePicker;
        
        startDateDatePicker.addTarget(self, action: #selector(LeaveRequestViewController .startDatePickerValueChanged), for: UIControlEvents.valueChanged);
        
    }
    
    @IBAction func endDateEditingBegin(_ sender: UITextField) {
        
        let endDateDatePicker = UIDatePicker();
        endDateDatePicker.datePickerMode = UIDatePickerMode.date;
        sender.inputView = endDateDatePicker;
        
        endDateDatePicker.addTarget(self, action: #selector(LeaveRequestViewController .endDatePickerValueChanged), for: UIControlEvents.valueChanged);
    }
    
    func startDatePickerValueChanged(sender:UIDatePicker) {
        txtStartDate.text = dateFormatter.string(from: sender.date);
    }
    
    func endDatePickerValueChanged(sender:UIDatePicker) {
        txtEndDate.text = dateFormatter.string(from: sender.date);
    }

    
    // Sets number of columns in picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    // Sets the number of rows in the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return leaveTypes.count;
    }
    
    // This function sets the text of the picker view to the content of the "salutations" array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return leaveTypes[row];
    }
    
    // When user selects an option, this function will set the text of the text field to reflect the selected option.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtLeaveType.text = leaveTypes[row];
    }
    

}


