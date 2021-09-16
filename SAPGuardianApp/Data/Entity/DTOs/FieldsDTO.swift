//
//  FieldsDTO.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 15/09/21.
//

import Foundation
import RealmSwift

class FieldsDTO: Object {
    
    @objc dynamic var body: String = ""
    @objc dynamic var thumbnail: String? = nil
    
    convenience init(_ body: String,_ thumbnail: String?) {
        self.init()
        self.body = body
        self.thumbnail = thumbnail
    }
}
