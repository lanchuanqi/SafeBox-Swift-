//
//  NoteModel.swift
//  Final
//
//  Created by logan on 7/28/15.
//  Copyright (c) 2015 logan. All rights reserved.
//

import UIKit
import CoreData

class NoteModel: NSManagedObject {
    // MARK: Properties(Core Data Attributes)
    @NSManaged var notename: String!
    @NSManaged var notedetail: String!

    // MARK: Properties(Core Data Relationships)
    @NSManaged var user: UserInfo
}
