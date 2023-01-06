//
//  Author+CoreDataProperties.swift
//  CoreData-Blog
//

//
//

import Foundation
import CoreData


extension Author {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Author> {
        return NSFetchRequest<Author>(entityName: K.Entity.author)
    }

    @NSManaged public var id: UUID?
    @NSManaged public var userName: String?
    @NSManaged public var profileImage: String?
    @NSManaged public var article: Article?

}

extension Author : Identifiable {

}
