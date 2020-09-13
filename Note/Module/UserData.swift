//
//  UserData.swift
//  Note
//
//  Created by Mac on 8/26/20.
//  Copyright © 2020 Mac. All rights reserved.
//
import ObjectMapper
import Foundation
class UserData : Mappable{
    var status : String?
    var message : String?
    var object : User?

    required init?(map: Map) {
          status    <- map["status"]
          message    <- map["message"]
          object    <- map["object"]
    }
    
    func mapping(map: Map) {
       status    <- map["status"]
       message    <- map["message"]
       object    <- map["object"]
    }
    
    
}
