//
//  Student.swift
//  Note
//
//  Created by Mac on 8/26/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import ObjectMapper
import Foundation
class Student : Mappable{
    var id : Int?
    var name : String?
   
    var email : String?
    var mobile : String?
    var email_verified_at : String?
    var status : String?
    var created_at : String?
    var api_uuid : String?
     var updated_at : String?
     var gender : String?
    var users_count : Int?
 
    required init?(map: Map) {
        id    <- map["id"]
        name    <- map["name"]

        email    <- map["email"]
        mobile    <- map["mobile"]
        status    <- map["status"]
        email_verified_at    <- map["email_verified_at"]
        api_uuid    <- map["api_uuid"]
        created_at    <- map["created_at"]
        updated_at    <- map["updated_at"]
            gender    <- map["gender"]
            users_count    <- map["users_count"]
        
        
    }
    
    func mapping(map: Map) {
        id    <- map["id"]
              name    <- map["name"]

              email    <- map["email"]
              mobile    <- map["mobile"]
              status    <- map["status"]
              email_verified_at    <- map["email_verified_at"]
              api_uuid    <- map["api_uuid"]
              created_at    <- map["created_at"]
              updated_at    <- map["updated_at"]
                  gender    <- map["gender"]
                  users_count    <- map["users_count"]
    }
    
    
}
