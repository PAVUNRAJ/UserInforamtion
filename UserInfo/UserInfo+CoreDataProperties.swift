//
//  UserInfo+CoreDataProperties.swift
//  
//
//  Created by Tech on 3/18/22.
//
//

import Foundation
import CoreData


extension UserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }

    @NSManaged public var first_name: String?
    @NSManaged public var last_name: String?
    @NSManaged public var email: String?
    @NSManaged public var avatar: String?
    @NSManaged public var id: Int64

}
