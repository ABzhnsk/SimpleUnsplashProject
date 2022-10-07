//
//  FavouritePhoto+CoreDataProperties.swift
//  SimpleUnsplashProject
//
//  Created by Anna Buzhinskaya on 07.10.2022.
//
//

import Foundation
import CoreData


extension FavouritePhoto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouritePhoto> {
        return NSFetchRequest<FavouritePhoto>(entityName: "FavouritePhoto")
    }

    @NSManaged public var countLikes: Int32
    @NSManaged public var createdAt: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var userLocation: String?
    @NSManaged public var userName: String?

}

extension FavouritePhoto : Identifiable {

}
