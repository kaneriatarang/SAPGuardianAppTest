//
//  NewsDetailsProtocols.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 13/09/21.
//

import Foundation

//MARK:- NewsDetailsView Protocol
protocol NewsDetailsViewType {
    func openURLOnApp(url: URL)
}

//MARK:- NewsDetailsViewModel Protocol
protocol NewsDetailsViewModelType {
    
    func attach(view: NewsDetailsViewType)
    func openWebURLOnBrowser()
    
    var selectedNews: News? { get set }
    var reloadData: ((News?) -> Void)? { get set }
}
