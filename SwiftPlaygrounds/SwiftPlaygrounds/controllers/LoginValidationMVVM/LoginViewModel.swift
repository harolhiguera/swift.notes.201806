//
//  LoginViewModel.swift
//  SwiftPlaygrounds
//
//  Created by Harol Higuera on 2018/09/30.
//  Copyright © 2018 Somanyideaz. All rights reserved.
//

import Foundation
import RxSwift


struct LoginViewModel{
    
    var emailText = Variable<String>("")
    var passwordText = Variable<String>("")
    
    var isValid: Observable<Bool> {
        return Observable.combineLatest(emailText.asObservable(), passwordText.asObservable()){ email, password in
            email.count >= 3 && password.count >= 3
        }
    }
    
    
}
