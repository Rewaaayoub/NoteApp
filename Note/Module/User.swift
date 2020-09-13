//
//  User.swift
//  Note
//
//  Created by Mac on 8/26/20.
//  Copyright © 2020 Mac. All rights reserved.
//
import ObjectMapper
import Foundation
class User : Mappable{
    static var currentUser:User?{
       return nil
    }
    var id : Int?
    var first_name : String?
    var last_name : String?
    var email : String?
    var mobile : String?
    var email_verified_at : String?
    var status : String?
    var created_at : String?
    var student_api_uuid : String?
     var updated_at : String?
     var token : String?
    var categories_count : Int?
    var notes_count : Int?
    var student :Student?
    required init?(map: Map) {
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
            student    <- map["student"]
        
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
          student    <- map["student"]
    }
    
    
}
