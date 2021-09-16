//
//  HomeViewModel.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 13/09/21.
//

import Foundation
import Combine
import RealmSwift
import Reachability

//MARK:- News List ViewModel
class HomeViewModel: HomeViewModelType {
    
    private var homeView : HomeViewType?
    private let homeManager: HomeUsecase
    private var cancellables = Set<AnyCancellable>()
    
    var newsList: [News] = []
    private var currentFetchedPage = 0
    private var isAPIUnderProcess = false
    
    init(manager: HomeUsecase) {
        homeManager = manager
    }
    
    func attach(view: HomeViewType) {
        homeView = view
        ReachabilityManager.shared.addListener(listener: self)
        fetchNewData(isNew: true)
    }
    
    deinit {
        ReachabilityManager.shared.removeListener(listener: self)
    }
    
    var reloadData: (() -> Void)?
    var isLoading: ((Bool) -> Void)?
    
    func fetchNewData(isNew: Bool) {
        
        // If newtwork not reachable fetch news from the Database
        guard ReachabilityManager.shared.isReachable else {
            getNewsFromDB()
            return
        }
        
        //Get News from API/Backend
        getNews(pageNumber: isNew ? 1 : currentFetchedPage + 1)
        
    }
    
    func fetchNewsInBackGroud() {
        getNews(pageNumber: currentFetchedPage + 1)
    }
    
    //API Call to fetch news based on Page Number
    private func getNews(pageNumber: Int) {
        
        let isFirstPageFetch = pageNumber == 1
        
        let request:[String: Any] = [:]
        let additionalQuery: [String: String] = ["page":String(pageNumber)]
        
        if isFirstPageFetch { isLoading?(true) }
        isAPIUnderProcess = true
        
        homeManager.searchNews(request: request, additionalQuery: additionalQuery)
            .receive(on: RunLoop.main)
            .sink {  [weak self] completion in
                self?.isAPIUnderProcess = false
                isFirstPageFetch ? self?.isLoading?(false) : self?.homeView?.updateFooter()
                switch completion {
                case .failure(let err):
                    print(err.localizedDescription)
                case .finished:
                    break
                }
            }
            receiveValue: { [weak self] searchResponse in
                
                guard let `self` = self else { return }
                let list = searchResponse.response?.results ?? []
                
                isFirstPageFetch ? self.newsList = list : self.newsList.append(contentsOf: list)
                
                if let page = searchResponse.response?.currentPage {
                    self.currentFetchedPage = page
                }
                
                //Save/Update newly added News in Database
                self.homeManager.saveNews(newsList: list)
                
                self.reloadData?()
            }
            .store(in: &cancellables)
    }
    
    //Fetch News from Database
    private func getNewsFromDB() {
        homeManager.getNews { [weak self] list in
            guard let `self` = self else { return }
            self.newsList = list
            self.reloadData?()
        }
    }
    
    //On Cell Selection Nevigate to Details Page
    func cellSelected(index: Int) {
        let news = newsList[index]
        homeView?.navigateToNewDetailsPage(news: news)
    }
}

//MARK:- Reachability Listener
extension HomeViewModel: ConnectionListener {
    func connectionChanged(status: Reachability.Connection) {
        //If Network Connected Fetch Latest News
        if status != .unavailable, !isAPIUnderProcess {
            fetchNewData(isNew: true)
        }
    }
    
}
