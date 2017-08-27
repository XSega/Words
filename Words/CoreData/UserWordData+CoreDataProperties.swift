//
//  UserWordData+CoreDataProperties.swift
//  Words
//
//  Created by Sergey Ilyushin on 10/08/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation
import CoreData


extension UserWordData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserWordData> {
        return NSFetchRequest<UserWordData>(entityName: "UserWordData")
    }

    @NSManaged public var identifier: Int32
    @NSManaged public var progress: Int32

}
