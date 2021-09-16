//
//  MoviesResponse.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 13/09/21.
//

import Foundation
import RealmSwift

struct News: Codable {
    let id: String
    let webPublicationDate: String?
    var webPublicationDateInAgoFormate: String? {
        return DateManager.formateDate(webDate: webPublicationDate)
    }
    let webTitle: String?
    let webUrl: String?
    let fields: Fields?
    
}

//MARK: - MappableProtocol Implementation
extension News: MappableProtocol{
    
    func mapToPersistenceObject() -> NewsDTO {
        let model = NewsDTO()
        model.id = id
        model.webPublicationDate = webPublicationDate
        model.webTitle = webTitle
        model.webUrl = webUrl
        model.fields = fields?.mapToPersistenceObject()
        return model
    }
    
    static func mapFromPersistenceObject(_ object: NewsDTO) -> News {
        return News(id: object.id, webPublicationDate: object.webPublicationDate, webTitle: object.webTitle, webUrl: object.webUrl, fields: Fields.mapFromPersistenceObject(object.fields!))
    }
    
}
