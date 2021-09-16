//
//  HomeUsecase.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 13/09/21.
//

import Foundation
import Combine

typealias RequestParams = [String: Any]

protocol HomeUsecase {
    func searchNews(request : RequestParams, additionalQuery: [String: String]?) -> Future<SerachResponse, Error>
    func getNews(completionHandler: ([News]) -> Void)
    func saveNews(newsList: [News])
}

protocol NewsRepositoryProtocol {
    
     func getAllNews(completionHandler: ([News]) -> Void)
     func saveNews(news: News)
     func updateNews(_ news: News)
}

