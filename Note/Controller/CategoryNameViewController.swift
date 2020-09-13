//
//  CategoryNameViewController.swift
//  Note
//
//  Created by Mac on 8/17/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class CategoryNameViewController: UIViewController {
    @IBOutlet weak var tableView : GeneralTableView!
    var categries : Category?
    var note : [CategoryNotes] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.parentVC = self
           self.navigationItem.backBarButtonItem?.title = ""
        UIViewController.registerNibTable(cell: tableView, identifer: "CategoryNameTableViewCell")
        getCategryNote()
      
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.backBarButtonItem?.title = ""
            getCategryNote()
    }
   
    @IBAction func createNote(_ sender: Any) {
        let vc :CreateNoteViewController = UIStoryboard.mainStoryboard.instantiateViewController(identifier: "CreateNoteViewController") as! CreateNoteViewController
        print(categries?.id!)
        vc.id = (categries?.id!)!
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
extension CategoryNameViewController {

    func getCategryNote(){
        let request = UserRequest.init(.categreNote)
        request.id = (categries?.id!)!
          self.tableView.baseRequest(request).identifier(identifier:"CategoryNameTableViewCell").objectsHandler { (baseResponse) -> [Any] in
          return  baseResponse?.list ??  []
          }.execute();
        
    }

}
