//
//  ViewController.swift
//  Note
//
//  Created by Mac on 7/17/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
class RounedView:UIView{
    override func layoutSubviews() {
        super.layoutSubviews();
        self.layer.cornerRadius = (self.frame.height/2);
        //  self.layer.cornerRadius = 3;
    }
}
class RoundedButton:UIButton{
    override func layoutSubviews() {
        super.layoutSubviews();
        self.layer.cornerRadius = (self.frame.height/2);
    }
}
class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
          self.navigationController?.navigationBar.shadowImage = UIImage()
          self.navigationController?.navigationBar.isTranslucent = true
          
      }

}

