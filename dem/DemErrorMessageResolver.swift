//
//  DemErrorMessageResolver.swift
//  dem
//
//  Created by Mossaddeque Mahmood on 3/20/17.
//  Copyright © 2017 Dynamic Solution Innovators. All rights reserved.
//

import Foundation
import Alamofire

class DemErrorMessageResolver {
    
    static let UNKNOWN_ERROR = "Unknown error occured.";
    static let DEM_SERVICE_0013_HAS_PENDING = "You cannot have more than one pending leave application.";
    static let DEM_SERVICE_0013_MUST_BE_CASUAL = "Post-leave request must be for casual leave.";
    
    static func getMessage(respJson: NSDictionary ) -> String {
            
        if respJson["errorCode"] as! String == "dem_service_0013" && respJson["errorType"] as! String == "hasPending"{
            return DEM_SERVICE_0013_HAS_PENDING
        }
        
        if respJson["errorCode"] as! String == "dem_service_0013" && respJson["errorType"] as! String == "mustBeCasual"{
            return DEM_SERVICE_0013_MUST_BE_CASUAL
        }
        
        return UNKNOWN_ERROR;
    }
}
