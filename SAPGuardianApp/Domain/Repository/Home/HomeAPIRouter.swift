//
//  HomeAPIRouter.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 13/09/21.
//

import Foundation

enum HomeAPIRouter: HTTP {
    
    case search(model: RequestParams)
   
    var method: HTTPMethod {
        switch self {
        case .search :
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .search:
            return "search"
        }
    }
    
    var queryList: [String: String]? {
        return ["api-key" : "ac950adb-eb0b-43e4-8c35-0f04ad27e696",
                "show-fields" : "thumbnail,body",
                "q": "Afghanistan"]
    }
}
