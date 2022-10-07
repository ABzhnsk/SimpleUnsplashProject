//
//  API.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 06.10.2022.
//

import Foundation

enum API {
    enum HTTPMethod: String {
        case get = "GET"
    }
    case getSearch(query: String, page: Int)
    
    var method: HTTPMethod {
        return .get
    }
    var baseURL: String {
        return "https://api.unsplash.com"
    }
    var path: String {
        switch self {
        case .getSearch:
            return "/search/photos"
        }
    }
    var query: [String: String] {
        switch self {
        case let .getSearch(query, page):
            return ["query": query, "per_page": "\(page)"]
        }
    }
    var header: [String: String] {
        return ["Authorization": "Client-ID \(Secrets.clientID)"]
    }
}
