//
//  NewsDBRepositoryTest.swift
//  SAPGuardianAppTests
//
//  Created by Tarang Kaneriya on 15/09/21.
//

import XCTest
import RealmSwift
@testable import SAPGuardianApp

class NewsDBRepositoryTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNewsDBRepo() throws {
        let dbManager: DataManager = MockRealmDataManager.getMockRealmDataManager()
        let newsRepo = NewsDBRepository(dbManager: dbManager)
        
        let news = NewsDTO("1212123", "2021-08-29T05:00:08Z", "Afghanistan Stub", nil, nil)
        
        try? newsRepo.save(object: news)
        
        newsRepo.fetch(NewsDTO.self, predicate: nil, sorted: nil) { (newsList) in
            XCTAssert(newsList[0].webTitle == "Afghanistan Stub", "News List object Should Match")
        }
        
    }

}
