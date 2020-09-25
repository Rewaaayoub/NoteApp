//
//  RealmClass.swift
//  Note
//
//  Created by Rewaa Ayoub on 9/18/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import RealmSwift
import Realm
import ObjectMapper_Realm

class RealmClass: UIViewController {
    
    static func addUser(user : User){
        let users = UserRealm(user)
        print(users.categories_count)
        try! AppDelegate.shared.realm?.write {
            AppDelegate.shared.realm?.add(users)
         }
        
     }
}
