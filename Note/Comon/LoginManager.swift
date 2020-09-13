//
//  LoginManager.swift
//  Note
//
//  Created by Rewaa Ayoub on 9/12/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class LoginManager: NSObject {

        static let sharedInstance = LoginManager()
           var loggedInUser: User? = nil
        
        override init() {
            super.init()
        }
    }


