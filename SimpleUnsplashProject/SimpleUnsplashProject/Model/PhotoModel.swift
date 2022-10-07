//
//  PhotoModel.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 06.10.2022.
//

import Foundation
import SwiftyJSON

struct PhotoModel: Codable {
    let imageUrl: String
    let userName: String
    let userLocation: String
    let createdAt: String
    let likes: Int
    
    init(_ json: JSON) {
        self.imageUrl = json["urls"]["full"].stringValue
        self.userName = json["user"]["username"].stringValue
        self.userLocation = json["user"]["location"].stringValue
        self.createdAt = json["created_at"].stringValue
        self.likes = json["likes"].intValue
    }
}
