//
//  PhotoModel.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 06.10.2022.
//

import Foundation

struct PhotoModel: Codable {
    let total: Int?
    let totalPages: Int?
    let results: [Photos]
}

struct Photos: Codable {
    let id: String?
    let urls: Urls?
    let user: Users?
    let createdAt: String?
    let likes: Int?
}

struct Urls: Codable {
    let full: String?
}

struct Users: Codable {
    let name: String?
    let location: String?
}
