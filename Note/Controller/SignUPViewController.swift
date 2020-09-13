//
//  SignUPViewController.swift
//  Note
//
//  Created by Mac on 7/18/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class SignUPViewController: UIViewController {
    var user : User?
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
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

    @IBAction func signUp(_ sender: Any) {
        print("ress")
              if (firstName.text!.count > 0) && (mobile.text!.count>0) && (password.text!.count>0) && (email.text!.count>0)&&(lastName.text!.count>0){
                  let register = UserRequest.init(.register)
                  register.email = email.text!
                  register.first_name = firstName.text!
                  register.last_name = lastName.text!
                  register.mobile = mobile.text!
                  register.password = password.text!
                  RequestOperationBuilder.init().request(register).showMessage(true).build().executeWithCheckResponse { (response) in
                    if response!.status!{
                        if let user : User = response!.object{
                        self.user = user
                              LoginViewController.loginApp(routing: true, email: user.email, password: self.password.text!, completionHandler: nil)
                          }
                      }else{
                        UIViewController.showMassages(title: "register", massage: response?.message! ?? "",vc: self)
                      }
                  }
          
              }else{
                   UIViewController.showMassages(title: "register", massage:"please fill all felid",vc: self)
              }
    }
    
}

