//
//  Logger.swift
//  dem
//
//  Created by Mossaddeque Mahmood on 2/22/17.
//  Copyright © 2017 Dynamic Solution Innovators. All rights reserved.
//

import Foundation

class Logger {

    static func debug(msg : Any) -> Void {
        print("[DEBUG] \(msg)");
    }
    
    static func error(msg : Any) -> Void {
        print("[ERROR] \(msg)");
    }
    
    
    static func warn(msg : Any) -> Void {
        print("[WARN] \(msg)");
    }
}
