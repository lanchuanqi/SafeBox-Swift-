//
//  UserInfo.swift
//  Final
//
//  Created by logan on 8/5/15.
//  Copyright (c) 2015 logan. All rights reserved.
//

import UIKit
import CoreData

class UserInfo: NSManagedObject {
    // MARK: Properties(Core Data Attributes)
    @NSManaged var username: String!
    @NSManaged var password: String!
    
    
    // MARK: Properties(Core Data Relationships)
    @NSManaged var album: NSSet
    @NSManaged var notes: NSSet
    
}
