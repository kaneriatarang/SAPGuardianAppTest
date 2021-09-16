//
//  NewsDTO.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 15/09/21.
//

import Foundation
import RealmSwift

class NewsDTO: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var webPublicationDate: String? = nil
    @objc dynamic var webTitle: String? = nil
    @objc dynamic var webUrl: String? = nil
    @objc dynamic var fields: FieldsDTO?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ id: String,_ webPublicationDate: String?,_ webTitle: String?,_ webUrl: String?,_ fields: FieldsDTO?) {
        self.init()
        self.id = id
        self.webPublicationDate = webPublicationDate
        self.webTitle = webTitle
        self.webUrl = webUrl
        self.fields = fields
    }
}


