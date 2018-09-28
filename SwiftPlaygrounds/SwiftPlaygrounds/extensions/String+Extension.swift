//
//  String+Extension.swift
//  SwiftPlaygrounds
//
//  Created by Harol Higuera on 2018/09/28.
//  Copyright © 2018 Somanyideaz. All rights reserved.
//

import Foundation


extension String {
    
    // Get Value from plist file
    func getValueFromPlist() -> String {
        if
            let file = Bundle.main.path(forResource: "credentials", ofType: "plist"),
            let dictionary = NSDictionary.init(contentsOfFile: file){
            return dictionary.value(forKey: self) as! String
        }
        else {
            return "Not Found"
        }
    }
    
    
}
