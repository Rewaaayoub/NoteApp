//
//  GeneralTableView.swift
//  Note
//
//  Created by Mac on 7/18/20.
//  Copyright © 2020 Mac. All rights reserved.


import UIKit

class GeneralTableViewData:NSObject{
    var identifier: String = ""
    var object: Any?
    var height : CGFloat?
    init(identifier: String, object: Any?,height : CGFloat?) {
        self.identifier=identifier;
        self.object=object;
        self.height=height
    }
}
//protocol GeneralTableViewCellProtocol{
//    var indexPath:IndexPath?{set get}
//    var object:GeneralTableViewData?{set get}
//    var parentVC : UIViewController!{set get}
//
//}
class GeneralTableViewCell: UITableViewCell {
    var indexPath:IndexPath?
    var object:GeneralTableViewData?
    weak open var parentVC : UIViewController!
     open var tableView : GeneralTableView!

    func config(){
        
    }
    func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, forObject object:GeneralTableViewData) {
    
    }
  func editing(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath,forObject object:GeneralTableViewData) {
    
}
}

class GeneralTableView: UITableView,UITableViewDelegate,UITableViewDataSource {
    // you can add pull torefresh
    // tou can add pagiation here
    var identifier:String?;
    var objects:[GeneralTableViewData]=[GeneralTableViewData]();
  //  var request:BaseRequest?
    var allowPullToRefresh:Bool=false{
        didSet{
            
        }
    }
    var parentVC : UIViewController?
    var baseRequest:BaseRequest?
    var enableEditing:Bool=false
    func enableEditing(_ enableEditing:Bool)->Self{
        self.enableEditing=enableEditing;
          return self
        }
    func allowPullToRefresh(_ allowPullToRefresh:Bool) -> Self{
        self.allowPullToRefresh = allowPullToRefresh
        if allowPullToRefresh{
            let refreshControl = UIRefreshControl()
                   refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
                                self.refreshControl = refreshControl
                                refreshControl.attributedTitle = NSAttributedString(string: "pull to refresh")
                                refreshControl.tintColor = UIColor.red
          
        }
       
        return self
    }
    @objc func refreshData(){
        self.execute()
    }
    var objectConverter:((Any)->GeneralTableViewData)?
    func objectConverter(_ objectConverter:((Any)->GeneralTableViewData)?)->Self{
     self.objectConverter=objectConverter;
       return self
     }
    func baseRequest(_ baseRequest:BaseRequest)->Self{
     self.baseRequest=baseRequest;
       return self
     }
    func objectsHandler(_ objectsHandler:((BaseResponse?)->[Any])?)->Self{
     self.objectsHandler=objectsHandler;
       return self
     }
       var objectsHandler:((BaseResponse?)->[Any])?


    func request(request:BaseRequest)->Self{
      return self
    }
    func identifier(identifier:String)->Self{
    self.identifier=identifier;
      return self
    }
    
    override func awakeFromNib() {
        super.awakeFromNib();
        self.delegate=self;
        self.dataSource=self;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects.count;
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: self.objects[indexPath.row].identifier ?? "") as? GeneralTableViewCell
        cell?.indexPath=indexPath;
            cell?.object=self.objects[indexPath.row]
        cell?.tableView=self;
        cell?.parentVC = self.parentVC
        cell?.config();
        return cell!;
     }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return enableEditing;
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            if let cell:GeneralTableViewCell = tableView.cellForRow(at: indexPath) as? GeneralTableViewCell{
                cell.editing(tableView ,commit :editingStyle, forRowAt: indexPath,forObject:self.objects[indexPath.row])
                self.objects.remove(at: indexPath.row)
                self.reloadData()
            }
        }else if(editingStyle == .insert){
            if let cell:GeneralTableViewCell = tableView.cellForRow(at: indexPath) as? GeneralTableViewCell{
                          cell.editing(tableView ,commit :editingStyle, forRowAt: indexPath,forObject:self.objects[indexPath.row])
                          self.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell:GeneralTableViewCell = tableView.cellForRow(at: indexPath) as? GeneralTableViewCell{
            cell.didselect(tableView, didSelectRowAt: indexPath, forObject: self.objects[indexPath.row])
        }
        
    }
//    func run(){
//        if let request:BaseRequest=request{
//
//            RequestOperationBuilder.init().request(request).build().showLodaer(false).didFinishHandler {
//
//            }.executeWithCheckResponse { (bas) in
//
//            }
//            }
            
//            sucessHandler({ (baseResponse) in
//            // here you will run request the request
//            // and you will call this for take array from inside success block response
//            if let baseResponse :BaseResponse = baseResponse{
//            var items = self.arrayHandler?(baseResponse) ?? []
//              var objects = items.map { (item) -> GeneralTableViewData in
//                    return GeneralTableViewData.init(identifier:self.identifier ?? "", object: item);
//                }
//                self.objects=objects;
//                self.reloadData();
//            }
//        }).errorHandler({ (error) in
//
//            }).executeWithCheckResponse()
 //   }
    
    
    func execute(){
         if let baseRequest:BaseRequest = self.baseRequest{
             RequestOperationBuilder.init().request(baseRequest).build().showLodaer(true).showMessage(true).executeWithCheckResponse { (baseResponse:BaseResponse?) in
             var objects = self.objectsHandler?(baseResponse)
                 var objectsArray:[GeneralTableViewData] = objects?.map({ (object) -> GeneralTableViewData in
                    return self.objectConverter?(object) ?? GeneralTableViewData.init(identifier:self.identifier ?? "", object: object, height: nil);
                     
                 }) ?? []
                 self.objects=objectsArray;
                if self.allowPullToRefresh{
            self.refreshControl!.endRefreshing()
                    }
                               
                 self.reloadData();
             }
         }
     }
    
}
