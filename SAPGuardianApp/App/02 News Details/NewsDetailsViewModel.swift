//
//  NewsDetailsViewModel.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 13/09/21.
//

import Foundation

//MARK:- News Details ViewModel
class NewsDetailsViewModel: NewsDetailsViewModelType {
    
    private var newsDetailsView : NewsDetailsViewType?
    
    var selectedNews: News?
    var reloadData: ((News?) -> Void)?
    
    init() {}
    
    func attach(view: NewsDetailsViewType) {
        newsDetailsView = view
        reloadData?(selectedNews)
    }
    
    //Website open based on the web URL in a new browser window
    func openWebURLOnBrowser() {
        if let stringURL = selectedNews?.webUrl, let url = URL(string: stringURL) {
            newsDetailsView?.openURLOnApp(url: url)
        }
    }
}
