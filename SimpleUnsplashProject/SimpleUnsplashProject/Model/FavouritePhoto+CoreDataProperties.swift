//
//  FavouritePhoto+CoreDataProperties.swift
//  
//
//  Created by Anna Buzhinskaya on 09.10.2022.
//
//

import Foundation
import CoreData


extension FavouritePhoto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouritePhoto> {
        return NSFetchRequest<FavouritePhoto>(entityName: "FavouritePhoto")
    }

    @NSManaged public var downloads: Int32
    @NSManaged public var createdAt: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var userLocation: String?
    @NSManaged public var userName: String?
    @NSManaged public var id: String?
    @NSManaged public var date: Date?
}
