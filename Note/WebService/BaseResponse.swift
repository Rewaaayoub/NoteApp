//
//  BaseResponse.swift
//  BuilderExample
//
//  Created by Mac on 6/28/20.
//  Copyright © 2020 Salah. All rights reserved.
//

import Foundation
import ObjectMapper
import ObjectMapper_Realm
import RealmSwift
import Realm

extension Realm{
    func customeWrite(handler:@escaping ()->Void){
        DispatchQueue.main.async {
               if AppDelegate.shared.realm?.isInWriteTransaction ?? false{
                handler();
               }else{
                try? AppDelegate.shared.realm?.write {
                       handler();
               }
               }
    }
}
}
class BaseResponse:NSObject,Mappable{
    var status : Bool?
    var message : String?
    var object : UserRealm?{
        didSet{
            if let object:UserRealm=object{
                AppDelegate.shared.realm?.customeWrite(handler: { () -> Void in
                    AppDelegate.shared.realm?.add(object, update: .all);
                })
            }
        }
    }
    var process_code : String?
    var list : [CategoryNotes]?
    var list2 : [Category]?
        required init?(map: Map) {
            status    <- map["status"]
             message    <- map["message"]
             object    <- map["object"]
            process_code <- map["process_code"]
            list <- map["list"]
            list2 <- map["list"]
        }
        func mapping(map: Map) {
            status    <- map["status"]
            message    <- map["message"]
            object    <- map["object"]
            process_code <- map["process_code"]
            list <- map["list"]
            list2 <- map["list"]
        }


}
