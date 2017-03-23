//
//  Status.swift
//  dem
//
//  Created by Mossaddeque Mahmood on 3/14/17.
//  Copyright © 2017 Dynamic Solution Innovators. All rights reserved.
//

import Foundation

struct Status {
    
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
