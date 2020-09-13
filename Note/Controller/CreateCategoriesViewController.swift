//
//  CreateCategoriesViewController.swift
//  Note
//
//  Created by Mac on 8/26/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import Alamofire
class CreateCategoriesViewController: UIViewController {
    var type : String = "create"
    var categre : Category?
    @IBOutlet weak var titles: UITextField!
    @IBOutlet weak var delatis: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if type == "update"{
            self.titles.text = categre?.title
            self.delatis.text = categre?.details
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func create(_ sender: Any) {
       switch type{
              case "update":
                  if (titles.text! != nil) && (delatis.text! != nil){
                      let categories = UserRequest.init(.categrieUpadte)
                      categories.title = titles.text!
                      categories.details = delatis.text!
                      categories.id = self.categre?.id;
                      RequestOperationBuilder.init().request(categories).build().executeWithCheckResponse { (response) in
                        if response?.status ?? false {
                      let vc = UIStoryboard.mainStoryboard.instantiateViewController(identifier: "CategoriesViewController") as! CategoriesViewController
                      self.navigationController?.popViewController(animated: true)
                          }else{
                      UIViewController.showMassages(title: "update", massage: (response?.message ?? ""), vc: self)
                          }
                      }
                  }else{
                        UIViewController.showMassages(title: "update", massage: "please fill all data", vc: self)
                  }
                  break;
              case "create":
                  if (titles.text! != nil) && (delatis.text! != nil){
                      let categories = UserRequest.init(.categories)
                       categories.title = titles.text!
                      categories.details = delatis.text!
                      RequestOperationBuilder.init().request(categories).build().executeWithCheckResponse { (response) in
                        if response?.status ?? false{
                            let vc = UIStoryboard.mainStoryboard.instantiateViewController(identifier: "CategoriesViewController") as! CategoriesViewController
                  self.navigationController?.popViewController(animated: true)
                          }else{
                  UIViewController.showMassages(title: "create", massage: (response?.message ?? ""), vc: self)
                              }
                      }
                  }else{
                  UIViewController.showMassages(title: "update", massage: "please fill all data", vc: self)
                     
                  }
                  break;
                  
              default:
                  print("non")
              }
    }
    
    
}
