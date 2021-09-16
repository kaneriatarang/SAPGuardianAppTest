//
//  NewsDBRepository.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 15/09/21.
//

import Foundation

//MARK: -  UserRepository
class NewsDBRepository : BaseRepository<NewsDTO> {
    
    
}

//MARK: -  UserRepositoryProtocol implementation
extension NewsDBRepository: NewsRepositoryProtocol {
    
    //MARK: - Methods
    func getAllNews(completionHandler: ([News]) -> Void) {
        super.fetch(NewsDTO.self, predicate: nil, sorted: nil) { (newsList) in
            completionHandler(newsList.map { News.mapFromPersistenceObject($0) } )
        }
    }
    func saveNews(news: News) {
        do { try super.save(object: news.mapToPersistenceObject()) }
        catch { print(error.localizedDescription) }
    }
    func updateNews(_ news: News) {
        do { try super.update(object: news.mapToPersistenceObject()) }
        catch { print(error.localizedDescription) }
    }
}
