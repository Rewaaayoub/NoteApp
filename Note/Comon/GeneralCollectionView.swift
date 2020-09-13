//
//  GeneralCollectionView.swift
//  Note
//
//  Created by Mac on 7/18/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation

import UIKit
class GeneralCollectionViewData:NSObject{
    var identifier: String = ""
    var object: Any?
    var size:CGSize?;
    init(identifier: String, object: Any?,size:CGSize?) {
        self.identifier=identifier;
        self.object=object;
        self.size=size;
    }
}
class GeneralCollectionViewCell: UICollectionViewCell {
    var indexPath:IndexPath?
    var object:GeneralCollectionViewData?
    weak open var parentVC : UIViewController!

    func config(){
        
    }
   
}

class GeneralCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    private var itemSize:CGSize?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.objects.count;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = self.objects[indexPath.row].size ?? self.itemSize ?? CGSize.zero;
        return size;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.objects[indexPath.row].identifier , for: indexPath) as? GeneralCollectionViewCell
        cell?.object = self.objects[indexPath.row];
                cell?.config();
                return cell!;
    }
    

      var identifier:String?;
      var objects:[GeneralCollectionViewData]=[GeneralCollectionViewData]();
      var baseRequest:BaseRequest?
      var objectsHandler:((BaseResponse?)->[Any])?
      var objectConverter:((Any)->GeneralCollectionViewData)?

      func identifier(identifier:String)->Self{
      self.identifier=identifier;
        return self
      }
      func itemSize(_ itemSize:CGSize)->Self{
      self.itemSize=itemSize;
        return self
      }
    func baseRequest(_ baseRequest:BaseRequest)->Self{
    self.baseRequest=baseRequest;
      return self
    }
    func objectConverter(_ objectConverter:((Any)->GeneralCollectionViewData)?)->Self{
    self.objectConverter=objectConverter;
      return self
    }
      override func awakeFromNib() {
          super.awakeFromNib();
          self.delegate=self;
          self.dataSource=self;
      }
    func execute(){
        if let baseRequest:BaseRequest = self.baseRequest{
            RequestOperationBuilder.init().request(baseRequest).build().showLodaer(false).showMessage(true).executeWithCheckResponse { (baseResponse:BaseResponse?) in
            var objects = self.objectsHandler?(baseResponse)
                var objectsArray:[GeneralCollectionViewData] = objects?.map({ (object) -> GeneralCollectionViewData in
                    return self.objectConverter?(object) ?? GeneralCollectionViewData.init(identifier:self.identifier ?? "", object: object, size: nil);
                    
                }) ?? []
                self.objects=objectsArray;
                self.reloadData();
            }
        }
    }
   
}
