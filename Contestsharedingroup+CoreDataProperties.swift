//
//  Contestsharedingroup+CoreDataProperties.swift
//  
//
//  Created by PRIYESH  on 5/29/20.
//
//

import Foundation
import CoreData


extension Contestsharedingroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contestsharedingroup> {
        return NSFetchRequest<Contestsharedingroup>(entityName: "Contestsharedingroup")
    }

    @NSManaged public var groupid: Int64
    @NSManaged public var groupname: String?
    @NSManaged public var sharedon: Date?

}
