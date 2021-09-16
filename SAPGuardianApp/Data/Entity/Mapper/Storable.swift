//
//  Storable.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 15/09/21.
//

import Foundation
import RealmSwift

//MARK: - Storable Protocol
public protocol Storable {
    
}

extension Object: Storable {
    
}

public struct Sorted {
    var key: String
    var ascending: Bool = true
}
