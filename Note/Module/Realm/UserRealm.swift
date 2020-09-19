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
class UserRealm: Object {
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
}
