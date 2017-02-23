//
//  AllPhotos.swift
//  Final
//
//  Created by logan on 7/30/15.
//  Copyright (c) 2015 logan. All rights reserved.
//

import UIKit
import CoreData

class AllPhotos: NSManagedObject {
    // MARK: Properties(Core Data Attributes)
    @NSManaged var data: Data!
    
    // MARK: Properties(Core Data Relationships)
    @NSManaged var album: Model
}
