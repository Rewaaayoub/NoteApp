//
//  SettingTableViewCell.swift
//  Note
//
//  Created by Mac on 8/21/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class SettingTableViewCell: GeneralTableViewCell {
    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var view: UIView!
     @IBOutlet weak var view2: UIView!

    static var identifier = "SettingTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func config() {
       if let object : Setting = self.object?.object as? Setting{
        self.images.image = object.image
        self.title.text = object.title
        self.desc.text = object.desc
        if let index: Int = indexPath?.row{
            if index%2 == 0{
               // self.view.isHidden = true
                 self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else{
                //self.view2.isHidden = true
                self.view2.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
        }
        
        }
    }
    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, forObject object: GeneralTableViewData) {
//        if indexPath.row == 1{
////            self.parentVC = SettingViewController.self as! UIViewController
//           parentVC.performSegue(withIdentifier: "profile", sender: nil)
//
//        }
        switch indexPath.row {
        case 0:
            //parentVC.performSegue(withIdentifier: "", sender: nil)
            print("lanague")
        case 1:
            if let vc :SettingViewController = parentVC as? SettingViewController{
                let user = vc.user
                let cv : ProfileViewController = UIStoryboard.mainStoryboard.instantiateViewController(identifier: "ProfileViewController") as! ProfileViewController
                cv.user = user
                parentVC.navigationController?.pushViewController(cv, animated: true)
            }
        case 2:
            parentVC.performSegue(withIdentifier: "aboutUs", sender: nil)
        case 3:
            print("non")
        case 4:
            let alert = UIAlertController(title: "logout", message: "are you sure to logout", preferredStyle: .alert)
                 // perferred style choose alert or action sheet
            alert.addAction(UIAlertAction(title: "yes", style: .default, handler: { (alert) in
                          let user = UserRequest.init(.logout)
                          RequestOperationBuilder.init().request(user).build().execute { (response) in
                          
                          }
                          AppDelegate.delegate.logout()
                      }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
          
            parentVC.present(alert, animated: true, completion: nil)
            
        default:
            print("non")
        }
    }
}
