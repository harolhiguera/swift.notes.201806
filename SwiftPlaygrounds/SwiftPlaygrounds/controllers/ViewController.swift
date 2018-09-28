//
//  ViewController.swift
//  SwiftPlaygrounds
//
//  Created by Harol Higuera on 2018/09/28.
//  Copyright © 2018 Somanyideaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get Value from plist file
        print("ApiKey is: \(Global.getApiKey())")
        
    }


}

