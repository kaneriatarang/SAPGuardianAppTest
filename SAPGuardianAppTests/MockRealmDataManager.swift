//
//  MockRealmDataManager.swift
//  SAPGuardianAppTests
//
//  Created by Tarang Kaneriya on 16/09/21.
//

import Foundation
import RealmSwift
@testable import SAPGuardianApp

class MockRealmDataManager {
    
    class func getMockRealmDataManager() -> DataManager {
        let realm = try? Realm(configuration: Realm.Configuration(inMemoryIdentifier: "MyInMemoryRealm"))
        return RealmDataManager(realm)
    }
}
