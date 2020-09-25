
//
//  SettingViewController.swift
//  Note
//
//  Created by Mac on 8/21/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    var setting : [Setting] = []
    var user : UserRealm?{
        didSet{
            if self.isViewLoaded{
                self.email2.text = self.user?.email ?? ""
                 self.name.text = "\(user?.first_name ?? "") \(user?.last_name ?? "")"
            }
        }
    }
    @IBOutlet weak var email2: UILabel!
       @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tableView: GeneralTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        user = UserRealm.currentUser
        UIViewController.registerNibTable(cell: tableView, identifer: "SettingTableViewCell")
        setting.append(Setting(image: #imageLiteral(resourceName: "language-24px"), title: "Language", desc: "Selected language: EN"))
        tableView.objects = [GeneralTableViewData(identifier: "SettingTableViewCell", object: setting[0], height: nil)]
        setting.append(Setting(image: #imageLiteral(resourceName: "perm_identity-24px"), title: "Profile", desc: "Update your data…"))
        setting.append(Setting(image: #imageLiteral(resourceName: "perm_device_information-24px"), title: "About App", desc: "What is notes app?"))
        setting.append(Setting(image: #imageLiteral(resourceName: "info-24px"), title: "About course", desc: " Describe the course in brief"))
        setting.append(Setting(image: #imageLiteral(resourceName: "exit2"), title: "Logout", desc: "Waiting your return…"))
        tableView.parentVC = self
        // Do any additional setup after loading the view.
        self.getData(identifers: "SettingTableViewCell", setting: self.setting)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        user = UserRealm.currentUser
    }


}
extension SettingViewController {
    public func getData(identifers : String , setting : [Setting]){
        for i in 1..<setting.count{
            self.tableView.objects.append(GeneralTableViewData(identifier: identifers, object: setting[i], height: nil))
        }
    }
}
