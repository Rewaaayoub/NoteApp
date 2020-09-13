//
//  ResponseHandler.swift
//  BuilderExample
//
//  Created by Mac on 6/28/20.
//  Copyright © 2020 Salah. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class ResponseHandler {
    // this will call inside block of alamofire operation
    static func checkResponse(showMessage:Bool,response : DataResponse<BaseResponse>, handel:((BaseResponse?)->Swift.Void)? = nil){
        switch response.result {
                      case .success(let data):
                        handel?(data)
                          print("");
                        break
                      case .failure(let err):
                        if response.response?.statusCode == 204 {
                            handel?(response.value)
                            
                        }else
                        if response.response?.statusCode == 500{
                           // CategoriesViewController.init().refrech()
                         let alert = UIAlertController(title: "Error", message: "Session expired,You should login again", preferredStyle: .alert)
                                           alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (alert) in
                                        AppDelegate.delegate.logout()
                                }))
                            AppDelegate.delegate.navigationController?.present(alert, animated: true, completion: nil)
                           
                        }else{
                            
                        }
                        break
        }

    }
    static func checkResponseforMulipartObject(showMessage:Bool,response:SessionManager.MultipartFormDataEncodingResult,handel:((BaseResponse?)->Swift.Void)? = nil){
        switch response{

        case .success(request: let request, streamingFromDisk: let streamingFromDisk, streamFileURL: let streamFileURL):
            request.responseObject { (response : DataResponse<BaseResponse>) in
                ResponseHandler.checkResponse(showMessage: showMessage, response: response, handel: handel)
                }
            break;
        case .failure(_):
            break;
        }
    }

    
}
