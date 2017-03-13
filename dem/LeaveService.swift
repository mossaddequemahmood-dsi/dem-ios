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
        Config.setPreference(key: "leave_type_id", value: "");
    }
    
    private func setPreferences(respJson: NSDictionary){
        Config.setPreference(key: "leave_type_id", value: respJson["access_token"] as! String);
    }
}

