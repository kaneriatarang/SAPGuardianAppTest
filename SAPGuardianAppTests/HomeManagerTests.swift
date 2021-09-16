//
//  HomeManagerTests.swift
//  SAPGuardianAppTests
//
//  Created by Tarang Kaneriya on 15/09/21.
//

import XCTest
import Combine
import RealmSwift
@testable import SAPGuardianApp

class HomeManagerTests: XCTestCase {
    
    private var manager: HomeUsecase?
    private var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        manager = HomeManagerMock()
    }
    
    override func tearDownWithError() throws {
        manager = nil
    }
    
    func testHomeManager() throws {
        
        let request:[String: Any] = [:]
        manager?.searchNews(request: request)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .failure:
                    XCTFail()
                case .finished:
                    break
                }
            }
            receiveValue: { newsResponse in
                
                XCTAssertTrue((newsResponse.response?.results?.count ?? 0) > 0, "News List Should not be nil")
                
                self.manager?.saveNews(newsList: newsResponse.response?.results ?? [])
                
                self.manager?.getNews { list in
                    XCTAssertTrue(list.count > 0, "News List from DB Should not be empty")
                }
            }
            .store(in: &cancellables)
    }
    
}
