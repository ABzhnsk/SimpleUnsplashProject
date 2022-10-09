//
//  PhotoModel.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 06.10.2022.
//

import Foundation
import SwiftyJSON

struct PhotoModel: Codable {
    let id: String
    let imageUrl: String
    let userName: String
    let userLocation: String
    let createdAt: String
    let downloads: Int
    
    init(_ json: JSON) {
        self.id = json["id"].stringValue
        self.imageUrl = json["urls"]["regular"].stringValue
        self.userName = json["user"]["username"].stringValue
        self.userLocation = json["user"]["location"].stringValue
        self.createdAt = json["created_at"].stringValue
        self.downloads = json["downloads"].intValue
    }
}
