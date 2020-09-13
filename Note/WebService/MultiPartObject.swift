//
//  MultiPartObject.swift
//  BuilderExample
//
//  Created by Mac on 6/28/20.
//  Copyright © 2020 Salah. All rights reserved.
//

import Foundation

class MultiPartObject
{
    //                formData?.appendPart(withFileData: userImage?.pngData, name: "s_avatar", fileName: "photo.png", mimeType: "image/png")
    var data:Data?
    var name:String?;
    var fileName:String?;
    var mimeType:String?;
    
    
    init(data:Data,name:String,fileName:String,mimeType:String) {
        self.data=data;
        self.name=name;
        self.fileName=fileName;
        self.mimeType=mimeType;
        
    }
}
