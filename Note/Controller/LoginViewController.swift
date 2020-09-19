//
//  ViewController.swift
//  Note
//
//  Created by Mac on 7/17/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import SVProgressHUD
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

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserDefaults.standard.token)
    }
    
    
    @IBAction func login(_ sender: Any) {
        LoginViewController.loginApp(routing: true, email: self.email.text, password: self.password.text, completionHandler: nil);


    }
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
          self.navigationController?.navigationBar.shadowImage = UIImage()
          self.navigationController?.navigationBar.isTranslucent = true
          
      }


}
extension LoginViewController{
    static func loginApp(routing : Bool? = true,email : String?=UserDefaults.standard.email,password : String? = UserDefaults.standard.password ,completionHandler:((Bool, BaseResponse?) -> Void)?){
       
        let  login = UserRequest.init(.login)
          login.email = email
          login.password = password
          //login.parameters
        RequestOperationBuilder.init().request(login).showMessage(true).showLodaer(true).build().executeWithCheckResponse { (response) in
            if response?.status ?? false {
                  if let user : User = response?.object{
                  UserDefaults.standard.email = email
                UserDefaults.standard.password = password
                  UserDefaults.standard.token = response?.object?.token
                    LoginManager.sharedInstance.loggedInUser = user
                    
                    if routing ?? true {
                       AppDelegate.delegate.route()
                    }
                    
                  }
                 
              completionHandler?(true, response)
                  
              }else{
                   completionHandler?(false, response)
              }
          }
      }
}
