//
//  Category.swift
//  Note
//
//  Created by Mac on 8/27/20.
//  Copyright © 2020 Mac. All rights reserved.
//
import ObjectMapper
import Foundation
class Category : Mappable{
    var id : Int?
    var title : String?
    var user_id :Int?
    var details : String?
    var notes_count : Int?
    var created_at : String?
     var updated_at : String?
    required init?(map: Map) {
        id    <- map["id"]
        title    <- map["title"]
        user_id    <- map["user_id"]
        details    <- map["details"]
        notes_count    <- map["notes_count"]
        created_at    <- map["created_at"]
        updated_at    <- map["updated_at"]
          }
    
    func mapping(map: Map) {
            id    <- map["id"]
            title    <- map["title"]
            details    <- map["details"]
            notes_count    <- map["notes_count"]
             created_at    <- map["created_at"]
             updated_at    <- map["updated_at"]
    }
    
    
}
