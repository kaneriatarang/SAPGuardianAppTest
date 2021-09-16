//
//  Fields.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 15/09/21.
//

import Foundation

struct Fields: Codable {
    
    let body: String
    let thumbnail: String?
    
    var bodyAttributed: NSAttributedString? { body.htmlAttributed(family: "Gill Sans", size: 12, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))}
}

//MARK: - MappableProtocol Implementation
extension Fields: MappableProtocol {
    
    func mapToPersistenceObject() -> FieldsDTO {
        let model = FieldsDTO()
        model.body = body
        model.thumbnail = thumbnail
        return model
    }
    
    static func mapFromPersistenceObject(_ object: FieldsDTO) -> Fields {
        return Fields(body: object.body, thumbnail: object.thumbnail)
    }
    
}
