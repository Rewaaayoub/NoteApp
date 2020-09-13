//
//  BaseRequest.swift
//  BuilderExample
//
//  Created by Mac on 6/28/20.
//  Copyright © 2020 Salah. All rights reserved.
//

import Foundation
import Alamofire
class BaseRequest:NSObject{
    var baseUrl:String=AppCosntants.DomainDevelopemnt;
    var multiPartObjects:[MultiPartObject]=[MultiPartObject]();
    var fullURL:String{
        return "\(baseUrl)\(url ?? "")"
    }
    var header : HTTPHeaders!{
        return nil
    }
    var token:String?{
        return nil;
    }
    var parameters:Dictionary<String,String>?{
        return nil
    } // request paramter
    var url:String?{
        return nil;
    }  // for request path
    var type:HTTPMethod!{
       return nil
    } // for post type : .post,.get,.delete
  
}
