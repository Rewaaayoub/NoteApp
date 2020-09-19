//
//  CategoriesTableViewCell.swift
//  Note
//
//  Created by Mac on 8/14/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import Alamofire
class CategoriesTableViewCell: GeneralTableViewCell {
  public static let identifier = "CategoriesTableViewCell"
    @IBOutlet weak var editB: UIButton!
    @IBOutlet weak var removeB: UIButton!
    @IBOutlet weak var work: UILabel!
    @IBOutlet weak var workNote: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func config() {
        if let object : Category = self.object?.object as? Category{
            self.work.text = object.title
            self.workNote.text = object.details
        }
    }
    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, forObject object: GeneralTableViewData) {
        let categries = self.object?.object as! Category
        let vc : CategoryNameViewController = parentVC.storyboard?.instantiateViewController(identifier: "CategoryNameViewController") as! CategoryNameViewController
        vc.categries = categries
        
        parentVC.navigationController?.pushViewController(vc, animated: true)
    }
    override func editing(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath, forObject object: GeneralTableViewData) {
        if editingStyle == .delete{
            let categries = self.object?.object as! Category
            let id = categries.id!
            let categories2 = UserRequest.init(.deleteCategries)
                 categories2.id = id
            RequestOperationBuilder.init().request(categories2).build().executeWithCheckResponse { (response) in
                UIViewController.showMassages(title: "delete", massage: response?.message ?? "", vc: self.parentVC)
               
            }
        }else if editingStyle == .insert{
           let categries = self.object?.object as! Category
           let vc : CreateCategoriesViewController = parentVC.storyboard?.instantiateViewController(identifier: "CreateCategoriesViewController") as! CreateCategoriesViewController
           vc.categre = categries
           vc.type = "update"
           parentVC.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0{
            return true
        }
         return false
    }
    @IBAction func remove(_ sender: Any) {
       UIViewController.showMassages(title: "delete", massage: "Are you want to remove note", vc: self.parentVC,{
                      let categries = self.object?.object as! Category
                          let id = categries.id!
                          let categories2 = UserRequest.init(.deleteCategries)
                               categories2.id = id
                          RequestOperationBuilder.init().request(categories2).build().executeWithCheckResponse { (response) in
                              UIViewController.showMassages(title: "delete", massage: response?.message ?? "", vc: self.parentVC,{
                                  if let indexPath:IndexPath = self.indexPath {
                                                 self.tableView.objects.remove(at: indexPath.row);
                                                 self.tableView.reloadData();
                                  }
                              })
                      }
                   })
    }
    @IBAction func edit(_ sender: Any) {
          let categries = self.object?.object as! Category
                let vc : CreateCategoriesViewController = parentVC.storyboard?.instantiateViewController(identifier: "CreateCategoriesViewController") as! CreateCategoriesViewController
                vc.categre = categries
                vc.type = "update"
                parentVC.navigationController?.pushViewController(vc, animated: true)
    }
//    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, forObject object: GeneralTableViewData) {
//        remove(removeB)
//        edit(editB)
//    }
}
