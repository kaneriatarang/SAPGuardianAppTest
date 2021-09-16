//
//  MappableProtocol.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 15/09/21.
//

import Foundation
import RealmSwift

//MARK: - MappableProtocol
protocol MappableProtocol {
    
    associatedtype PersistenceType: Storable
    
    //MARK: - Method
    func mapToPersistenceObject() -> PersistenceType
    static func mapFromPersistenceObject(_ object: PersistenceType) -> Self
    
}

