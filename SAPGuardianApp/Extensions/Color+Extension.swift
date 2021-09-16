//
//  Color+Extension.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 15/09/21.
//

import UIKit

extension UIColor {
    //MARK:- UIColor to HexCode of Color
    var hexString:String? {
        if let components = self.cgColor.components {
            let r = components[0]
            let g = components[1]
            let b = components[2]
            return  String(format: "%02X%02X%02X", (Int)(r * 255), (Int)(g * 255), (Int)(b * 255))
        }
        return nil
    }
}
