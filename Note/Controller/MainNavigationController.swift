//
//  MainNavigationController.swift
//  Note
//
//  Created by Rewaa Ayoub on 8/31/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AppDelegate.delegate.navigationController=self;
        AppDelegate.delegate.route();
        // Do any additional setup after loading the view.
    }
    

}

