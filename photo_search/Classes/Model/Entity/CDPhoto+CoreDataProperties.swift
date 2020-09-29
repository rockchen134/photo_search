//
//  CDPhoto+CoreDataProperties.swift
//  
//
//  Created by Rock Chen on 2020/9/28.
//
//

import Foundation
import CoreData


extension CDPhoto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPhoto> {
        return NSFetchRequest<CDPhoto>(entityName: "CDPhoto")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?

}
