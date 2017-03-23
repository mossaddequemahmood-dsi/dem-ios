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
    
    static let casualLeaveApplication : String = "Casual Leave Application";
    static let sickLeaveApplication : String = "Sick Leave Application";
    
    func postLeaveRequest(leaveType: String, startDateStr: String, endDateStr: String, reason: String, callback: @escaping (Status) -> Void){

        let token = Config.getPreference(key: "access_token")!;
        let accessToken = "Bearer $(\(token))";
        
        let baseUrl = Config.get(key: "BaseURL") ?? "";
        let leaveReqUrl = baseUrl + Config.get(key: "LeaveRequestURL") ;
        
        let startDate : Date = parseStrDate(strDate: startDateStr);
        let endDate : Date = parseStrDate(strDate: endDateStr);

        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd";
        
        guard let leaveTypeId = try? getLeaveTypeID(leaveType: leaveType) else {
            print("leaveTypeId not found.");
            return
        }
        
        let leaveReqBody : [String: Any] = [
            "leaveRequestTypeId" : getLeaveRequestTypeId(endDate: endDate),
            "leaveTypeId" : leaveTypeId,
            "startDate" : dateFormatter.string(from: startDate),
            "endDate" : dateFormatter.string(from: endDate),
            "leaveReason" : reason,
            "version" : 1
         ];

        let headers: HTTPHeaders = [
            "Authorization": accessToken,
            "Accept": "application/json"
        ]
        
        Alamofire.request(
            leaveReqUrl,
            method: HTTPMethod.post,
            parameters: leaveReqBody,
            encoding: JSONEncoding.default,
            headers: headers).debugLog().responseJSON { response in
                

                if let data = response.data {
                    let json = String(data: data, encoding: String.Encoding.utf8)
                    print("Failure Response: \(json)")
                }

                
                /*guard response.result.error == nil else {
                    Logger.error(msg: response.result.error!)
                    return
                }*/
                
                if let value = response.result.value {
                    
                    let respJson = value as! NSDictionary
                    
                    if respJson["errorCode"] == nil {
                        callback(Status(status: true, statusMessage: "Request successful."));
                    } else {
                        let msg = DemErrorMessageResolver.getMessage(respJson: respJson);
                        callback(Status(status: false, statusMessage: msg));
                        Logger.error(msg: respJson);
                    }

                }
        }
    }
    
    private func parseStrDate(strDate : String) -> Date {
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "MMM dd, yyyy";
        return dateFormatter.date(from: strDate)!;
    }
    
    private func calculateDaysBetween(startDate: Date, endDate: Date) -> Int {
        let currentCalendar = Calendar.current
        
        guard let start = currentCalendar.ordinality(of: .day, in: .era, for: startDate) else { return 0 }
        guard let end = currentCalendar.ordinality(of: .day, in: .era, for: endDate) else { return 0 }
        
        return start - end;
    }
    
    private func getLeaveTypeID(leaveType: String) throws -> String {
        
        if leaveType == LeaveService.casualLeaveApplication {
            return Config.get(key: "CasualLeaveTypeID");
        } else if leaveType == LeaveService.sickLeaveApplication {
            return Config.get(key: "SickLeaveTypeID");
        } else {
            throw "Illegal leave type.";
        }
    }
    
    private func getLeaveRequestTypeId(endDate : Date) -> String {
        
        let currentDate = Date();
        
        if currentDate < endDate  {
            return Config.get(key: "PreLeaveRequestTypeID");
        } else {
            return Config.get(key: "PostLeaveRequestTypeID");
        }
    }
    
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
                        //self.setPreferences(respJson: respJson);
                    } else {
                        //self.resetPreferences();
                    }
                    
                }
        }
        
    }
    

}

