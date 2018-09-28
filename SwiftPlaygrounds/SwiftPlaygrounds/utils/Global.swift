//
//  Global.swift
//  SwiftPlaygrounds
//
//  Created by Harol Higuera on 2018/09/28.
//  Copyright © 2018 Somanyideaz. All rights reserved.
//

import Foundation


struct Global {
    
    static func getApiKey() -> String {
        return "ApiKey".getValueFromPlist()
    }
    
}
