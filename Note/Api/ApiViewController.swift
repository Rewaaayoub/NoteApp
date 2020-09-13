//
//  ApiViewController.swift
//  Note
//
//  Created by Mac on 8/27/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import Alamofire

class ApiViewController: UIViewController {
    var sessionToken: String? {
           get {
               return UserDefaults.standard.string(forKey: "token")
           }
           set {
               UserDefaults.standard.set(newValue, forKey: "token")
           }
       }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
//    static func loginApp(email : String,password : String ,completionHandler: @escaping (Bool, BaseResponse?) -> Void){
//          let  login = UserRequest.init(.login)
//          login.email = email
//          login.password = password
//          //login.parameters
//          RequestOperationBuilder.init().request(login).showMessage(true).build().executeWithCheckResponse { (response) in
//              if response.status!{
//                  let defaults: UserDefaults = UserDefaults.standard
//                  if let user : User = response.object{
//                      defaults.set(user.email, forKey: "email")
//                   
//                      defaults.set(password, forKey: "password")
//                      defaults.set(user.token, forKey: "token")
//                   defaults.synchronize()
//                  }
//                 
//              completionHandler(true, response)
//                  
//              }else{
//                   completionHandler(false, response)
//              }
//          }
//      }
/////// /// ///                         ////////////                        /////////////
    // resgister
    static func register(first_name :String , last_name:String,email :String,mobile:String,password:String,api_uuid :String ,completionHandler: @escaping (Bool, BaseResponse?) -> Void){
          let register = UserRequest.init(.register)
          register.api_uuid = api_uuid
          register.email = email
          register.first_name = first_name
          register.last_name = last_name
          register.mobile = mobile
          register.password = password
          RequestOperationBuilder.init().request(register).showMessage(true).build().executeWithCheckResponse { (response) in
            if response?.status ?? false{
                  completionHandler(true,response)
              }else{
                  completionHandler(false,response)
              }
          }
      }
    
    
    
    static func update(first_name :String , last_name:String,email :String,mobile:String,completionHandler: @escaping (Bool, BaseResponse?) -> Void){
        let updata = UserRequest.init(.update)
        updata.email = email
        updata.first_name = first_name
        updata.last_name = last_name
        updata.mobile = mobile
        if let token :String = UserDefaults.standard.string(forKey: "token"){
            updata.token1 = "Bearer \(token)"
            RequestOperationBuilder.init().request(updata).build().executeWithCheckResponse { (response) in
                if response?.status ?? false{
                    UserDefaults.standard.set(email, forKey: "email")
                    completionHandler(true, response)
                }else{
                     completionHandler(false, response)
                }
            }
        }
        
    }
    
    
    
    static func categories(completionHandler: @escaping (Bool, BaseResponse?) -> Void){
        let categories = UserRequest.init(.categorie)
        if let token :String = UserDefaults.standard.string(forKey: "token"){
            categories.token1 = "Bearer \(token)"
            RequestOperationBuilder.init().request(categories).build().executeWithCheckResponse { (response) in
                if response?.status ?? false {
                    completionHandler(true, response)
                }else{
                     completionHandler(false, response)
                }
            }
        }
    }
    static func cat(){
        
        let token :String = UserDefaults.standard.string(forKey: "token")!
        print("Bearer \(token)")
        Alamofire.request("http://notes.mr-tech.tech/api/categories",method: .get ,headers: ["authorization" : "Bearer \(token)"]).validate().responseJSON { (response) in
           debugPrint(response)
        print("gucjdfkfr")
           if let data : Data = response.data, let str : String = String(data: data, encoding: .utf8){
              print(str)
           print("noo")
           }

             }
    }
    
    
    
    
    static func createCategories(title:String,details :String ,completionHandler: @escaping (Bool, BaseResponse?) -> Void){
        let categories = UserRequest.init(.categories)
        categories.title = title
        categories.details = details
        if let token :String = UserDefaults.standard.string(forKey: "token"){
            categories.token1 = "Bearer \(token)"
            RequestOperationBuilder.init().request(categories).build().executeWithCheckResponse { (response) in
                if response?.status ?? false{
                    completionHandler(true, response)
                }else{
                     completionHandler(false, response)
                }
            }
        }
    }
    
    
    
    static func logout(completionHandler: @escaping (Bool, BaseResponse?) -> Void){
        let logout = UserRequest.init(.logout)
        if let token :String = UserDefaults.standard.string(forKey: "token"){
            logout.token1 = "Bearer \(token)"
                   RequestOperationBuilder.init().request(logout).build().executeWithCheckResponse { (response) in
                    if response?.status ?? false{
                        UserDefaults.standard.removeObject(forKey: "token")
                         UserDefaults.standard.removeObject(forKey: "email")
                         UserDefaults.standard.removeObject(forKey: "password")
                         UserDefaults.standard.synchronize()
                        completionHandler(true, response)
                        
                       }else{
                            completionHandler(false, response)
                       }
                   }
               }
    }
       
    
    
    static func createNote(title:String,details :String,category_id : Int,completionHandler: @escaping (Bool, BaseResponse?) -> Void){
        let note = UserRequest.init(.Note)
        note.title = title
        note.details = details
        note.category_id = category_id
        if let token :String = UserDefaults.standard.string(forKey: "token"){
            note.token1 = "Bearer \(token)"
            RequestOperationBuilder.init().request(note).build().executeWithCheckResponse { (response) in
                if response?.status ?? false {
                    completionHandler(true, response)
                }else{
                     completionHandler(false, response)
                }
            }
        }
    }
    
    
    
    static func updateCategories(title:String,details :String,id :Int ,completionHandler: @escaping (Bool, BaseResponse?) -> Void){
           let categories = UserRequest.init(.categrieUpadte)
           categories.title = title
           categories.details = details
        categories.id = id
           if let token :String = UserDefaults.standard.string(forKey: "token"){
               categories.token1 = "Bearer \(token)"
               RequestOperationBuilder.init().request(categories).build().executeWithCheckResponse { (response) in
                   if response?.status ?? false{
                       completionHandler(true, response)
                   }else{
                        completionHandler(false, response)
                   }
               }
           }
       }
    
    
    static func deleteCategories(id :Int ,completionHandler: @escaping (Bool, BaseResponse?) -> Void){
        let categories = UserRequest.init(.deleteCategries)
        categories.id = id
        if let token :String = UserDefaults.standard.string(forKey: "token"){
            categories.token1 = "Bearer \(token)"
            RequestOperationBuilder.init().request(categories).build().executeWithCheckResponse { (response) in
                if response?.status ?? false{
                    completionHandler(true, response)
                }else{
                     completionHandler(false, response)
                }
            }
        }
    }
    
    
    
    
    static func categoriesNotes(id :Int ,completionHandler: @escaping (Bool, BaseResponse?) -> Void){
        let categoriesNote = UserRequest.init(.categreNote)
        categoriesNote.id = id
        if let token :String = UserDefaults.standard.string(forKey: "token"){
            categoriesNote.token1 = "Bearer \(token)"
            RequestOperationBuilder.init().request(categoriesNote).build().executeWithCheckResponse { (response) in
                if response?.status ?? false{
                    completionHandler(true, response)
                }else{
                     completionHandler(false, response)
                }
            }
        }
    }
    
    
   static func updateNote(title:String,details :String,id :Int ,completionHandler: @escaping (Bool, BaseResponse?) -> Void){
            let note = UserRequest.init(.updateNote)
            note.title = title
            note.details = details
         note.id = id
            if let token :String = UserDefaults.standard.string(forKey: "token"){
                note.token1 = "Bearer \(token)"
                RequestOperationBuilder.init().request(note).build().executeWithCheckResponse { (response) in
                    if response?.status ?? false{
                        completionHandler(true, response)
                    }else{
                         completionHandler(false, response)
                    }
                }
            }
        }
     
    
    static func deleteNote(id :Int ,completionHandler: @escaping (Bool, BaseResponse?) -> Void){
           let note = UserRequest.init(.deleteNote)
           note.id = id
           if let token :String = UserDefaults.standard.string(forKey: "token"){
               note.token1 = "Bearer \(token)"
               RequestOperationBuilder.init().request(note).build().executeWithCheckResponse { (response) in
                if response?.status ?? false{
                       completionHandler(true, response)
                   }else{
                        completionHandler(false, response)
                   }
               }
           }
       }
    
    
     static func updateStatus(id :Int ,completionHandler: @escaping (Bool, BaseResponse?) -> Void){
         let status = UserRequest.init(.updateStatus)
         status.id = id
         if let token :String = UserDefaults.standard.string(forKey: "token"){
             status.token1 = "Bearer \(token)"
             RequestOperationBuilder.init().request(status).build().executeWithCheckResponse { (response) in
                if response?.status ?? false {
                     completionHandler(true, response)
                 }else{
                      completionHandler(false, response)
                 }
             }
         }
     }
}
