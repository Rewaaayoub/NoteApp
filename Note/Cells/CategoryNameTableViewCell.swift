//
//  CategoryNameTableViewCell.swift
//  Note
//
//  Created by Mac on 8/17/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import Alamofire
class CategoryNameTableViewCell: GeneralTableViewCell {
    public static var identifiers = "CategoryNameTableViewCell"
    @IBOutlet weak var title : UILabel!
  
    @IBOutlet weak var desc: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func config() {
      if let object:CategoryNotes = self.object?.object as? CategoryNotes{
        self.title.text = object.title
        self.desc.text = object.details
        }
    }
    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, forObject object: GeneralTableViewData) {
        let note = self.object?.object as! CategoryNotes
        let id = note.id
        let vc : CreateNoteViewController = parentVC.storyboard?.instantiateViewController(identifier: "CreateNoteViewController") as! CreateNoteViewController
        vc.note = note
        vc.type = "update"
        vc.id = id
        parentVC.navigationController?.pushViewController(vc, animated: true)
        
    }
    override func editing(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath, forObject object: GeneralTableViewData) {
        if editingStyle == .delete{
                  let note = self.object?.object as! CategoryNotes
                  let id = note.id!
            let note2 = UserRequest.init(.deleteNote)
            note2.id = id
            RequestOperationBuilder.init().request(note2).build().executeWithCheckResponse { (response) in
                UIViewController.showMassages(title: "delete", massage: response?.message ?? "", vc: self.parentVC)
            }
            }
    }
}
