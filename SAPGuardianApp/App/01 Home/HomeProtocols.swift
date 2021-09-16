//
//  HomeProtocols.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 13/09/21.
//

import Foundation

//MARK:- HomeView Protocol
protocol HomeViewType {
    func navigateToNewDetailsPage(news: News)
    func updateFooter()
}

//MARK:- HomeViewModel Protocol
protocol HomeViewModelType {
    
    func attach(view: HomeViewType)
    var isLoading: ((Bool) -> Void)? { get set }
    var reloadData: (() -> Void)? { get set }
    var newsList: [News] { get }
    func fetchNewData(isNew: Bool)
    func cellSelected(index: Int)
}
