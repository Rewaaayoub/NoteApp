//
//  extenstionViewController.swift
//  Note
//
//  Created by Rewaa Ayoub on 8/29/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

extension UIViewController{
    public static func registerNibTable(cell : UITableView , identifer : String){
        let nib = UINib(nibName: identifer, bundle: nil)
        cell.register(nib, forCellReuseIdentifier: identifer)
    }
    public static func registerNibCollcetion(cell : UICollectionView , identifer : String){
           let nib = UINib(nibName: identifer, bundle: nil)
        cell.register(nib, forCellWithReuseIdentifier: identifer)
       }
    static func showMassages(title : String , massage : String,vc : UIViewController,_ okHandler:(()->Void)?=nil){
           let alert = UIAlertController(title: title, message: massage, preferredStyle: .alert)
                // perferred style choose alert or action sheet
        alert.addAction(UIAlertAction.init(title: "ok", style:  .default, handler: { (item) in
            okHandler?();
        }))
        if okHandler != nil{
            alert.addAction(UIAlertAction.init(title: "canel", style:  .cancel, handler:nil))
        }
           vc.present(alert, animated: true, completion: nil)

       }
}


