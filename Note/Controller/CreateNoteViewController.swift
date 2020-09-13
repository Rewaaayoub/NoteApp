//
//  CreateNoteViewController.swift
//  Note
//
//  Created by Mac on 8/26/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class CreateNoteViewController: UIViewController {
    var id : Int?
    var type : String = "create"
    var note : CategoryNotes?
    @IBOutlet weak var titles: UITextField!
    @IBOutlet weak var details: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if type == "update"{
            self.details.text = note?.details
            self.titles.text = note?.title
        }
  print(id)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(_ sender: Any) {
        switch type{
        case "update":
            if (self.titles.text! != nil) && (self.details.text! != nil) && (self.id != nil){
                let note = UserRequest.init(.updateNote)
                note.title = self.titles.text!
                note.details = self.details.text!
                note.id = self.id
                RequestOperationBuilder.init().request(note).executeWithCheckResponse { (response) in
                    if response?.status ?? false {
                        let alert = UIAlertController(title: "update", message: (response?.message ?? ""), preferredStyle: .alert)
                           alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (alert) in
                            self.navigationController?.popViewController(animated: true)
                            }))
                                self.present(alert, animated: true, completion: nil)
                        }else{
                        UIViewController.showMassages(title: "update", massage: (response?.message ?? ""), vc: self)
                    }
                }
            }else{
                UIViewController.showMassages(title: "update note", massage: "please fill all data", vc: self)
            }
            break;
        case "create":
            if (self.titles.text! != nil) && (self.details.text! != nil) && (self.id != nil){
                let note = UserRequest.init(.Note)
                      note.title = self.titles.text!
                      note.details = self.details.text!
                      note.category_id = self.id
                RequestOperationBuilder.init().request(note).build().executeWithCheckResponse { (response) in
                    let alert = UIAlertController(title: "create", message: (response?.message ?? ""), preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (alert) in
                    self.navigationController?.popViewController(animated: true)
                    }))
                        self.present(alert, animated: true, completion: nil)
        
                }
            }else{
              UIViewController.showMassages(title: "create note", massage: "please fill all data", vc: self)
            }
            break
        default:
            print("non")
        }
    }
    
    
}
