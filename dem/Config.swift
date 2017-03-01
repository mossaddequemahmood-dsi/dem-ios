//
//  Config.swift
//  dem
//
//  Created by Mossaddeque Mahmood on 2/22/17.
//  Copyright © 2017 Dynamic Solution Innovators. All rights reserved.
//

import Foundation

class Config {
    
    static func get(key: String) -> String! {
        
        let path : String = Bundle.main.path(forResource: "app", ofType: "plist")!;
        let dict = NSDictionary(contentsOfFile: path);
        
        if let value : String = dict!.object(forKey: key) as? String {
            return value;
        }
        
        return nil;
    }
    
    static func getPreference(key: String) -> String! {
        return UserDefaults.standard.string(forKey: key)!;
    }
    
    static func setPreference(key: String, value: String) {
        UserDefaults.standard.set(value, forKey: key);
    }
}
