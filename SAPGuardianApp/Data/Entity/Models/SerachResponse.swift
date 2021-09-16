//
//  SerachResponse.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 15/09/21.
//

import Foundation

struct SerachResponse: Codable {
    let response: NewsResponse?
}

struct NewsResponse: Codable {
    let status: String
    let total: Int?
    let startIndex: Int?
    let pageSize: Int?
    let currentPage: Int?
    let pages: Int?
    let results: [News]?
}
