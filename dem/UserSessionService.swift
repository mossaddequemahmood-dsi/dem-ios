//
//  UserSession.swift
//  dem
//
//  Created by Mossaddeque Mahmood on 2/22/17.
//  Copyright © 2017 Dynamic Solution Innovators. All rights reserved.
//

import Foundation
import Alamofire

class UserSessionService {
    
    struct LoginStatus {
        
        let status: Bool;
        let statusMessage: String;
        
        init(status: Bool, statusMessage: String) {
            self.status = status;
            self.statusMessage = statusMessage;
        }
        
        func getStatus() -> Bool {
            return self.status;
        }
        
        func getStatusMessage() -> String {
            return self.statusMessage;
        }
        
    }
    
    func login(username: String, password: String, callback: @escaping (LoginStatus) -> Void){

        resetPreferences();
        
        let tetantId = Config.get(key: "AuthTenantID") ?? "";
        
        let baseUrl = Config.get(key: "BaseURL") ?? "";
        let authUrl = baseUrl + Config.get(key: "AuthURL") ;
        
        Logger.debug(msg: "tetantID: \(tetantId)");
        Logger.debug(msg: "authUrl: \(authUrl)");
        
        Alamofire.request(
            authUrl,
            method: HTTPMethod.post,
            parameters: ["username": username, "password": password, "tenant_id": tetantId],
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

                    if Config.getPreference(key: "access_token") != "" {
                        callback(LoginStatus(status: true, statusMessage: "Login Successful."));
                    } else {
                        callback(LoginStatus(status: false, statusMessage: "Login username/password not matched."));
                        
                    }
                }
        }

    }
    
    func getAccessToken() -> String {
        return Config.getPreference(key: "access_token");
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

