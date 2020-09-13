//
//  ProfileViewController.swift
//  Note
//
//  Created by Mac on 8/28/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import Alamofire
class ProfileViewController: UIViewController {
    var user : User?
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var email2: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var gmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        user = LoginManager.sharedInstance.loggedInUser

        getData()
        // Do any additional setup after loading the view.
    }
    func getData(){
        self.firstName.text = user?.first_name
        self.lastName.text = user?.last_name
        self.mobile.text = user?.mobile
        self.gmail.text = user?.email
        self.email2.text = user?.email
        self.name.text = "\(user?.first_name ?? "") \(user?.last_name ?? "")"
    }
    @IBAction func update(_ sender: Any) {
    let updata = UserRequest.init(.update)
           updata.email = gmail.text!
           updata.first_name = firstName.text!
           updata.last_name = lastName.text!
           updata.mobile = mobile.text!
        RequestOperationBuilder.init().request(updata).build().executeWithCheckResponse { (response) in
            if response?.status ?? false {
                UIViewController.showMassages(title: "update", massage: (response?.message ?? ""), vc: self)
        self.user = response?.object
                LoginManager.sharedInstance.loggedInUser = self.user
         self.getData()
     }else{
        UIViewController.showMassages(title: "update", massage: (response?.message ?? ""), vc: self)
     }
    }
    }
    
   
}
