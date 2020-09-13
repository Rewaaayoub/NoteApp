//
//  CategoriesViewController.swift
//  Note
//
//  Created by Mac on 8/14/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import Alamofire
class CategoriesViewController: UIViewController {
    @IBOutlet weak var tableView: GeneralTableView!
    var categories : [Category] = []
    var user : User?
    override func viewDidLoad() {
        super.viewDidLoad()
        UIViewController.registerNibTable(cell: tableView, identifer: "CategoriesTableViewCell")
       tableView.parentVC = self
        getDataCategries()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true;      self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        getDataCategries()
}
    @IBAction func setting(_ sender: Any) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(identifier: "SettingViewController") as! SettingViewController
        vc.user = self.user
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getDataCategries(){
        let request = UserRequest.init(.categorie)
        self.tableView.allowPullToRefresh(true)
        self.tableView.baseRequest(request).identifier(identifier:"CategoriesTableViewCell").objectsHandler { (baseResponse) -> [Any] in
            return  baseResponse?.list2 ??  []
        }.execute();
        

         }
        
    }


extension CategoriesViewController {
//
//
//   public func refrech(){
//        LoginViewController.loginApp(routing: false, email: UserDefaults.standard.email, password: UserDefaults.standard.password) { (status, response) in
//            if status{
//                print("sucesss")
//            }
//        }
//    }
//
    
}
