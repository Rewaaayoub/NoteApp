 //
 //  UserRealm.swift
 //  Note
 //
 //  Created by Rewaa Ayoub on 9/18/20.
 //  Copyright © 2020 Mac. All rights reserved.
 //

 import Foundation
 import Realm
 import RealmSwift
 import ObjectMapper_Realm
 import ObjectMapper
 class UserRealm: Object,Mappable {
     static var currentUser:UserRealm?{
         return AppDelegate.shared.realm?.objects(UserRealm.self).filter({ (item) -> Bool in
             return item.id == UserDefaults.standard.id
             }).first
     }
     @objc dynamic var id = 0
        @objc dynamic var email = ""
        @objc dynamic var first_name = ""
        @objc dynamic var last_name = ""
        @objc dynamic var email_verified_at = ""
        @objc dynamic var mobile = ""
        @objc dynamic var status = ""
        @objc dynamic var created_at = ""
        @objc dynamic var updated_at = ""
        @objc dynamic var student_api_uuid = ""
        @objc dynamic var categories_count = 0
        @objc dynamic var token = ""
        @objc dynamic var notes_count = 0
        override class func primaryKey() -> String? {
            return "id"
        }
        required convenience init?(map: Map) {
         self.init()
          id    <- map["id"]
                first_name    <- map["first_name"]
                last_name    <- map["last_name"]

                email    <- map["email"]
                mobile    <- map["mobile"]
                status    <- map["status"]
             
                email_verified_at    <- map["email_verified_at"]
                student_api_uuid    <- map["student_api_uuid"]
                created_at    <- map["created_at"]
                updated_at    <- map["updated_at"]
                    token    <- map["token"]
                    categories_count    <- map["categories_count"]
                    notes_count    <- map["notes_count"]
     }
     

     
     func mapping(map: Map) {
          id    <- map["id"]
                first_name    <- map["first_name"]
                last_name    <- map["last_name"]

                email    <- map["email"]
                mobile    <- map["mobile"]
                status    <- map["status"]
             
                email_verified_at    <- map["email_verified_at"]
                student_api_uuid    <- map["student_api_uuid"]
                created_at    <- map["created_at"]
                updated_at    <- map["updated_at"]
                    token    <- map["token"]
                    categories_count    <- map["categories_count"]
                    notes_count    <- map["notes_count"]
     }
     
    
 }

