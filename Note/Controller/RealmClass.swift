//
//  RealmClass.swift
//  Note
//
//  Created by Rewaa Ayoub on 9/18/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class RealmClass: UIViewController {
    
    static func addUser(user : User){
     let users = UserRealm()
        users.f
         try! AppDelegate.shared.realm.write {
             AppDelegate.shared.realm.add(user)
         }
     }
}
