//
//  Alamofire+Request.swift
//  dem
//
//  Created by Mossaddeque Mahmood on 3/14/17.
//  Copyright © 2017 Dynamic Solution Innovators. All rights reserved.
//

import Foundation
import Alamofire

extension Request {
    public func debugLog() -> Self {
        #if DEBUG
            debugPrint(self)
        #endif
        return self
    }
}
