//
//  AppDelegate.swift
//  Note
//
//  Created by Mac on 7/17/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
extension UserDefaults{
    var email: String? {
            get {
                return UserDefaults.standard.string(forKey: "email")
                
            }
            set {
                UserDefaults.standard.set(newValue, forKey: "email")
                UserDefaults.standard.synchronize()
                
            }
        }
    var password: String? {
        get {
            return UserDefaults.standard.string(forKey: "password")
            
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "password")
            UserDefaults.standard.synchronize()
        }
    }
    var token: String? {
        get {
            return UserDefaults.standard.string(forKey: "token")
            
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "token")
            UserDefaults.standard.synchronize()
            AppDelegate.delegate.updateHeaders()
        }
    }
}
import Alamofire
extension UIStoryboard{
  static let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
}
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
        
    func updateHeaders(){
        
        if var token:String = UserDefaults.standard.token {
//            token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNTVkNTUwMzAzY2Q2YzU2YjRmZGQ3ZjQ1NjYyMzM4ZmFkMTcwNjViMzg0NjIxYTMxZWFhNzU3MTk5ODQxMTM1NDM1NWNmMTQxOWNlYjQ5ZTIiLCJpYXQiOjE1OTg5NDEwODgsIm5iZiI6MTU5ODk0MTA4OCwiZXhwIjoxNjMwNDc3MDg4LCJzdWIiOiI2NiIsInNjb3BlcyI6W119.BZ1T_vvxXIz5aZkchL3A_O8eOy1rU4xgACcMirF80-C7jBXoZzZVp0DDjNCkIcdudRY47EyYz3JZj8-kWKL5mY45qQwxFZJ8fjglLciH2gCgVHyMonq6KV1nsdIzjwNqCGOkFEGEIPrlk-n2tr1T80l4SPksDiTFzTiteQcRxdM4F0xbptwBPw7mun8d21m94DTYw6whfh4etwjbjhxJya-Vpm3Vh9d576kxHYmy9DLGG-Vu3CQOBIU2cz3y-NGiwyKbJY2W0cxP6TKZRejjvQadj1FKZImmmrGnHZKrPX1ZnAjFugqFGQ7280SOtqCeXYtpMjiZ3QgzBT6iIuuzeiaoLBAQ019jJC5Jc5Fct3phUfjjZ2tt7QweigNfyFCGkfF-fjUDpS3rD9XI6r8ieSZMBEZDZ1Lps-jNNj-oSWe7WvF35Deyl39GR-B3D320eAyAfldqO2HFaTKQ4RZRFmXxBi1QpjItFFeoMmEJea0k8vIYPYHL5H_Bq1xYfCx445iBo23itCWHFJqK0tW0p5XJpJD0iKGIIjzTh5veZQf8pLMPKcb_BeMKnPz-r9wh4oZwehYQGz43P9S2lRtwKisSX6S_JtQxzW9Xd4EDoGB2YvDhubuaiL6_9jdfJNQakA6R-37KeHVqgkF5S4gOLHGar8hWkms0fdcmPqU8zkk";
            RequestOperationBuilder.header["authorization" ] = "Bearer \(token)";
            
        }else{
            RequestOperationBuilder.header.removeValue(forKey:"authorization");
        }

    }
    func logout(){

        UserDefaults.standard.token = nil
         LoginManager.sharedInstance.loggedInUser = nil
        updateHeaders()
        route()
    }
    func route(){
        if UserDefaults.standard.token != nil{
        
            let vc = UIStoryboard.mainStoryboard.instantiateViewController(identifier: "CategoriesViewController") as! CategoriesViewController
            self.navigationController?.viewControllers = [vc]
            print(UIApplication.shared.windows.first?.rootViewController)
        }else{
           let vc = UIStoryboard.mainStoryboard.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
                   self.navigationController?.viewControllers = [vc]
        }
    }
    public var navigationController:UINavigationController?
//    {
//        return UIApplication.shared.windows.first?.rootViewController as? UINavigationController
//    }
    public static var delegate:AppDelegate{
      return UIApplication.shared.delegate as! AppDelegate;
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       // UserDefaults.standard.token = "1020304040404"
        self.updateHeaders();
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
         print(UIApplication.shared.windows.first?.rootViewController)
    }
}

