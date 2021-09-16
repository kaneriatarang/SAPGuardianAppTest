//
//  HomeManagerMock.swift
//  SAPGuardianAppTests
//
//  Created by Tarang Kaneriya on 15/09/21.
//

import Foundation
import Combine
import RealmSwift
@testable import SAPGuardianApp

class HomeManagerMock: CommonManager, HomeUsecase {
    
    func searchNews(request: RequestParams) -> Future<SerachResponse, Error> {
        let request = buildRequest(http: HomeAPIRouter.search(model: request))
        let fileName = MockUrlJson.dic[request.url?.absoluteString ?? ""] ?? ""
        let response: Future<SerachResponse, Error> = MockNetworkManager.shared.request(fileName)
        return response
    }
    
    func getNews(completionHandler: ([News]) -> Void) {
       
        let dbManager: DataManager = MockRealmDataManager.getMockRealmDataManager()
        let repo = NewsDBRepository(dbManager: dbManager)
        repo.getAllNews(completionHandler: { (list) in
           completionHandler(list)
        })
    }
    
    func saveNews(newsList: [News]) {
        let dbManager: DataManager = MockRealmDataManager.getMockRealmDataManager()
        let repo:NewsRepositoryProtocol = NewsDBRepository(dbManager: dbManager)
        
        for news in newsList {
            repo.updateNews(news)
        }
    }

}

class MockUrlJson {
    static let dic: [String:String] = [
        "https://content.guardianapis.com/search?q=Afghanistan&show-fields=thumbnail,body&api-key=ac950adb-eb0b-43e4-8c35-0f04ad27e696":"NewsFirstPage"
    ]
}






