//
//  HomeViewModelTest.swift
//  SAPGuardianAppTests
//
//  Created by Tarang Kaneriya on 15/09/21.
//

import XCTest
@testable import SAPGuardianApp

class HomeViewModelTest: XCTestCase {
    
    private var homeViewModel: HomeViewModel?

    override func setUpWithError() throws {
        homeViewModel = HomeViewModel(manager: HomeManager())
    }

    override func tearDownWithError() throws {
        homeViewModel = nil
    }

    func testHomeViewModel() throws {
        let exp = expectation(description: "News fetch")

        homeViewModel?.reloadData = { [weak self] in

            if let list = self?.homeViewModel?.newsList {
                XCTAssertTrue(list.count > 0 , "News List Can not be empty")
            } else {
                XCTFail()
            }
            exp.fulfill()
        }

        homeViewModel?.getNews()

        waitForExpectations(timeout: 10)

    }
}
