//
//  Notes.swift
//  Note
//
//  Created by Mac on 8/27/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import ObjectMapper
import Foundation
class CategoryNotes : Mappable{
    var id : Int?
    var title : String?
   
    var details : String?
    var category_id : Int?
  
    var status : String?
    var created_at : String?

     var updated_at : String?

 
    required init?(map: Map) {
        id    <- map["id"]
        title    <- map["title"]

        details    <- map["details"]
        category_id    <- map["category_id"]
        status    <- map["status"]
       
        created_at    <- map["created_at"]
        updated_at    <- map["updated_at"]
          
        
        
    }
    
    func mapping(map: Map) {
        id    <- map["id"]
             title    <- map["title"]

             details    <- map["details"]
             category_id    <- map["category_id"]
             status    <- map["status"]
            
             created_at    <- map["created_at"]
             updated_at    <- map["updated_at"]
    }
    
    
}
