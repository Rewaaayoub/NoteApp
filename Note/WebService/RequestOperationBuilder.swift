
//
//  RequestBuilder.swift
//  BuilderExample
//
//  Created by Salah on 3/26/20.
//  Copyright © 2020 Salah. All rights reserved.
//
import ObjectMapper
import UIKit
import Alamofire
import AlamofireObjectMapper
import SVProgressHUD
import MBProgressHUD
extension UIViewController {
    func showHud(_ message: String) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = message
        hud.isUserInteractionEnabled = false
    }

    func hideHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
extension UIViewController{
    func showProgress(){
    SVProgressHUD.show();
    }
    func dismissProgress(){
        SVProgressHUD.dismiss();
    }
}



class RequestOperationBuilder: NSObject {
    var baseRequest:BaseRequest?
    var showLodaer:Bool=false;
    var showMessage:Bool=false;
    var didFinishHandler:(() ->Swift.Void)?
//    var sucessHandler:((BaseResponse) ->Swift.Void)?
//    var errorHandler:((Error) ->Swift.Void)?
    var dataRequest:DataRequest!;
    var request:URLRequest!
    var dataResponse:DataResponse<BaseResponse>?
    var partAlamofire:((MultipartFormData) -> Void)?
    static var header : HTTPHeaders=HTTPHeaders()
    func request(_ request: BaseRequest)->Self{
         self.baseRequest = request
         return self
     }
//    func header(_ request: HTTPHeaders)->Self{
//            self.header = header
//            return self
//    }
//    func sucessHandler(_ sucessHandler: ((BaseResponse) ->Swift.Void)?)->Self{
//        self.sucessHandler = sucessHandler
//        return self
//    }
//    func errorHandler(_ errorHandler: ((Error) ->Swift.Void)?)->Self{
//        self.errorHandler = errorHandler
//        return self
//    }
    func showMessage(_ showMessage: Bool)->Self{
        self.showMessage = showMessage
        return self
    }
    func didFinishHandler(_ didFinishHandler:@escaping (() ->Swift.Void))->Self{
        self.didFinishHandler = didFinishHandler
        return self
    }
    func showLodaer(_ showLodaer: Bool)->Self{
        self.showLodaer = showLodaer
        return self
    }
    func build()->Self{
        
        if (self.baseRequest?.multiPartObjects.count ?? 0) > 0{
          self.partAlamofire={ (formData:MultipartFormData) in
            for object in self.baseRequest?.multiPartObjects ?? []
            {
              formData.append(object.data!, withName: object.name!, fileName: object.fileName!, mimeType: object.mimeType!)
            }
            for object in (self.baseRequest?.parameters ?? Dictionary<String,String>()){
               let key = object.key
               let value = object.value.data(using:.utf8)!;
               formData.append(value, withName:key);
            }
          }
        }
        do {
            if let type:HTTPMethod = self.baseRequest?.type , let url:URL = URL.init(string:self.baseRequest?.fullURL ?? ""){
                //"\(AppCosntants.api)/\(self.baseRequest?.url ?? "")"
//                if self.baseRequest?.token!.count ?? 0 <= 0{
//                   self.request = try URLRequest.init(url:url, method:type, headers: nil);
//                }else{
                self.request = try URLRequest.init(url:url, method:type, headers:self.allHeaders());
                //}
//                print(self.baseRequest?.header)
//                print(url)
                self.request = try URLEncoding.default.encode(self.request, with:self.baseRequest?.parameters);

            }else{
                print("aa");
            }
        }catch {
            print(error);
        }
        
        
    // here you set your request
    
     return self
    }
    func executeWithCheckResponse( handler:((BaseResponse?) ->Swift.Void)?)->Self{

                if self.showLodaer{
                    AppDelegate.delegate.navigationController!.showHud("loading")
//                    DispatchQueue.main.async {
//                        UIApplication.shared.windows.first?.rootViewController?.showProgress();
//
//                        SVProgressHUD.show();
//
//                    }
                }
            self.dataRequest = Alamofire.SessionManager.default.request(self.request).responseObject { (response : DataResponse<BaseResponse>) in
                print(response.request?.url);
                      print(response.response?.statusCode);
                print((String.init(bytes:response.data!, encoding: .utf8) as! NSString));
                ResponseHandler.checkResponse(showMessage: self.showMessage, response: response) { (baseResponse) in
                    handler?(baseResponse);
                }
                self.didFinishHandler?()
                print(String.init(bytes:response.data!, encoding: .utf8) as! NSString);
                if self.showLodaer{
                    AppDelegate.delegate.navigationController!.hideHUD()
//                    DispatchQueue.main.async {
//                    SVProgressHUD.dismiss()
//                        UIApplication.shared.windows.first?.rootViewController?.dismissProgress();
//                    }

                }
            }
             // here you will run thee request
        return self;
    }
    func execute(_ handler:@escaping (DataResponse<BaseResponse>)->Void)->Self{

                if self.showLodaer{
                    DispatchQueue.main.async {
                        UIApplication.shared.windows.first?.rootViewController?.showProgress();
                        SVProgressHUD.show();
                    
                    }
                }
            self.dataRequest = Alamofire.SessionManager.default.request(self.request).responseObject { (response : DataResponse<BaseResponse>) in
            
                print(String.init(bytes:response.data!, encoding: .utf8) as! NSString);
                if self.showLodaer{
                    DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                        UIApplication.shared.windows.first?.rootViewController?.dismissProgress();
                    }
                    
                }
                handler(response);
                self.didFinishHandler?()
//                switch response.result {
//                case .success(let data):
//                    self.sucessHandler?(data);
//                    print("");
//                  break
//                case .failure(let err):
//                    self.errorHandler?(err);
//                  break
//                }
            }
             // here you will run thee request
              return self
     }
     func  executeMultiPart(handel:((BaseResponse?)->Swift.Void)? = nil) {

     Alamofire.upload(multipartFormData: self.partAlamofire!, with: self.request) { (result) in
        ResponseHandler.checkResponseforMulipartObject(showMessage: self.showMessage, response: result) { (baseResponse:BaseResponse?) in
            handel?(baseResponse);
        }
        self.didFinishHandler?();
     }
     }
    func allHeaders()->HTTPHeaders{
        var headers = HTTPHeaders();
        
        headers.bs_merge(dict:RequestOperationBuilder.header)
    
     //  headers.bs_merge(dict:self.baseRequest?.header)
       
        return headers;
    }
}
public extension Dictionary {
mutating func bs_merge(dict: [Key: Value]?){
    if let  dict:[Key: Value]=dict{
  for (k, v) in dict {
    updateValue(v, forKey: k)
  }
    }
    }}
