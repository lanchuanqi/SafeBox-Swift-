//
//  Model.swift
//  Final
//
//  Created by logan on 7/27/15.
//  Copyright (c) 2015 logan. All rights reserved.
//

import UIKit
import CoreData


class Model: NSManagedObject {
    
    // MARK: Properties(Core Data Attributes)
    @NSManaged var name: String!
    
    
    // MARK: Properties(Core Data Relationships)
    @NSManaged var photos: NSSet
    @NSManaged var user: UserInfo
}
