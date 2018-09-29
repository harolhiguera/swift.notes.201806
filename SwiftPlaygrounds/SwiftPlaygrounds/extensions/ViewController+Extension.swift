//
//  ViewController+Extension.swift
//  SwiftPlaygrounds
//
//  Created by Harol Higuera on 2018/09/29.
//  Copyright © 2018 Somanyideaz. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func getDeviceWidth() -> CGFloat {
        var result = CGFloat()
        if let window = UIApplication.shared.keyWindow {
            result = window.bounds.width
        }else{
            result = self.view.bounds.width
        }
        return result
    }
}
