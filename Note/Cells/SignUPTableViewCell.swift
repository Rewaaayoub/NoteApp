//
//  SignUPTableViewCell.swift
//  Note
//
//  Created by Mac on 7/18/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class SignUPTableViewCell: GeneralTableViewCell {
     public static let identifier = "identifier"
    @IBOutlet weak var TFDate: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func config() {
        if let object:String=self.object?.object as? String{
            self.TFDate.placeholder = object
        }
    }
}
