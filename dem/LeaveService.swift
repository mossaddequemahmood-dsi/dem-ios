//
//  LeaveService.swift
//  dem
//
//  Created by Mossaddeque Mahmood on 2/28/17.
//  Copyright © 2017 Dynamic Solution Innovators. All rights reserved.
//

import Foundation

import Alamofire

class LeaveService {
    

    func fetchStoreLeaveType() -> Void {
        
        let leaveTypeUrl: String = Config.getPreference(key: "leaveTypeUrl");
        
        Alamofire.request(
            leaveTypeUrl,
            method: HTTPMethod.get,
            encoding: JSONEncoding.default,
            headers: nil).responseJSON { response in
                
                guard response.result.error == nil else {
                    Logger.error(msg: response.result.error!)
                    return
                }
                
                if let value = response.result.value {
                    let respJson = value as! NSDictionary
                    
                    if respJson["errorCode"] == nil {
                        self.setPreferences(respJson: respJson);
                    } else {
                        self.resetPreferences();
                    }
                    
    
                }
        }
        
    }
    
    func getLeaveTypeId() -> String {
        return Config.getPreference(key: "leave_type_id");
    }
    
    private func resetPreferences(){
        Config.setPreference(key: "access_token", value: "");
        Config.setPreference(key: "first_name", value: "");
        Config.setPreference(key: "last_name", value: "");
        Config.setPreference(key: "login_id", value: "");
        Config.setPreference(key: "tenant_name", value: "");
        Config.setPreference(key: "user_id", value: "");
        Config.setPreference(key: "username", value: "");
    }
    
    private func setPreferences(respJson: NSDictionary){
        Config.setPreference(key: "access_token", value: respJson["access_token"] as! String);
        Config.setPreference(key: "first_name", value: respJson["first_name"] as! String);
        Config.setPreference(key: "last_name", value: respJson["last_name"] as! String);
        Config.setPreference(key: "login_id", value: respJson["login_id"] as! String);
        Config.setPreference(key: "tenant_name", value: respJson["tenant_name"] as! String);
        Config.setPreference(key: "user_id", value: respJson["user_id"] as! String);
        Config.setPreference(key: "username", value: respJson["username"] as! String);
    }
}

