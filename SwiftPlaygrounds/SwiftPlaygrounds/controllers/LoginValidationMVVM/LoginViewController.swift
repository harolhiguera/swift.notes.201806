//
//  LoginViewController.swift
//  SwiftPlaygrounds
//
//  Created by Harol Higuera on 2018/09/30.
//  Copyright © 2018 Somanyideaz. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet weak var field_email: UITextField!
    @IBOutlet weak var field_password: UITextField!
    @IBOutlet weak var btn_login: UIButton!
    @IBOutlet weak var label: UILabel!
    
    var viewModel = LoginViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Bind the textfields to the ViewModel
        // If the first variable is nil return an empty string
        // Tell the view model that the input of this view has changed
        _ = field_email.rx.text.map { $0 ?? "" }.bind(to: viewModel.emailText)
        _ = field_password.rx.text.map { $0 ?? "" }.bind(to: viewModel.passwordText)
        
        // Bind the isValid Result to the login button. Enable the login btn when the result is valid
        _ = viewModel.isValid.bind(to: btn_login.rx.isEnabled)
        
        viewModel.isValid.subscribe(onNext:{ [unowned self] isvalid in
            self.label.text = isvalid ? "Enable" : "Not enable"
            self.label.textColor = isvalid ? .green : .red
        }).disposed(by: disposeBag)
        
    }

    @IBAction func onLogin(_ sender: UIButton) {
        
        
    }
    

}
