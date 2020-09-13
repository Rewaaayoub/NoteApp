//
//  UserRequest.swift
//  BuilderExample
//
//  Created by Salah on 3/26/20.
//  Copyright © 2020 Salah. All rights reserved.
//

import UIKit
import Alamofire
//            // "http://sadeemapp.com/?json=get_main_screen"

class UserRequest: BaseRequest {
    enum Route {
      case login
      case Note
      case register
      case categories
     case update
     case logout
        case categorie
        case categrieUpadte
        case deleteCategries
        case categreNote
        case updateNote
        case deleteNote
        case updateStatus
    }
     var route:Route
  var token1: String = ""
    override var token: String{
        return token1
    }
     var first_name:String?
     var last_name:String?
     var email:String?
    var mobile:String?
     var password:String?
    var api_uuid:String = "581b3f45-46ee-4dfc-adce-674a47ba98db"
    var title:String?
    var category_id : Int?
     var details:String?
    var id : Int?
    init(_ route:Route) {
        self.route = route
    }
    override var header: HTTPHeaders{
        
        return ["authorization" : token]
    }
    override var url : String {
        switch self.route {
        case .login:
            return "user/login"
        case .register:
            return "user/register"
        case .Note:
            return "notes";
        case .categories:
            return "categories"
        case .update:
            return "user/update"
        case .logout:
            return "user/logout"
        case .categorie:
            return "categories"
        case .categrieUpadte:
            return "categories/\(id!)"
        case .deleteCategries:
            return "categories/\(id!)"
        case .categreNote:
            return "categories/\(id!)/notes"
        case .updateNote:
            return "notes/\(id!)"
        case .deleteNote:
            return "notes/\(id!)"
        case .updateStatus:
            return "notes/\(id!)/status"
        }
    }
    override var parameters: Dictionary<String, String>?{
        var parameters:Dictionary<String, String> = Dictionary<String, String>();
        switch self.route{
            
        case .login:
        parameters["email"]=email;
        parameters["password"]=password;
            break;
        case .Note :
            parameters["title"]=title;
            parameters["details"]=details;
            parameters["category_id"]=category_id?.description;

            break;
        case .register:
        parameters["first_name"]=first_name;
        parameters["last_name"]=last_name;
        parameters["email"]=email;
        parameters["mobile"]=mobile;
        parameters["api_uuid"]=api_uuid;
        parameters["password"]=password;
            break;
        case .categories:
        parameters["title"]=title;
        parameters["details"]=details;
            break
        case .update:
            parameters["first_name"]=first_name;
            parameters["last_name"]=last_name;
            parameters["email"]=email;
            parameters["mobile"]=mobile;
        case .logout:
            print("non")
        case .categorie:
            break
        case .categrieUpadte:
            parameters["title"]=title;
            parameters["details"]=details;
        case .deleteCategries:
            break;
        case .categreNote:
            break
        case .updateNote:
            parameters["title"]=title;
            parameters["details"]=details;
        case .deleteNote:
            break
        case .updateStatus:
            break
        }
        return parameters;
    }
    override var type :HTTPMethod {
        switch self.route {
        case .login,.register,.Note:
            return .post
        case .categories:
            return .post
        case .update:
            return .put
        case .logout:
            return .get
        case .categorie:
            return .get
        case .categrieUpadte:
            return .put
        case .deleteCategries:
            return .delete
        case .categreNote:
            return .get
        case .updateNote:
            return .put
        case .deleteNote:
            return .put
        case .updateStatus:
            return .get
        }
    }
    
    

}
