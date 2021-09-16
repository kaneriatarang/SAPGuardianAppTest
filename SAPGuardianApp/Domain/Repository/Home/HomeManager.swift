//
//  HomeManager.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 13/09/21.
//

import Foundation
import Combine

class HomeManager: CommonManager, HomeUsecase {
    
    func searchNews(request : RequestParams, additionalQuery: [String: String]?) -> Future<SerachResponse, Error> {
        let request = buildRequest(http: HomeAPIRouter.search(model: request), additionalQuery: additionalQuery)
        let response: Future<SerachResponse, Error> = NetworkManager.shared.request(request)
        return response
    }
    
    func getNews(completionHandler: ([News]) -> Void) {
        let dbManager: DataManager = RealmDataManager(RealmProvider.default)
        let repo = NewsDBRepository(dbManager: dbManager)
        repo.getAllNews(completionHandler: { (list) in
           completionHandler(list)
        })
    }
    
    func saveNews(newsList: [News]) {
        let dbManager: DataManager = RealmDataManager(RealmProvider.default)
        let repo:NewsRepositoryProtocol = NewsDBRepository(dbManager: dbManager)
        
        for news in newsList {
            repo.updateNews(news)
        }
    }
}


