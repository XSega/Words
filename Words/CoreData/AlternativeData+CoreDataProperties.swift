//
//  AlternativeData+CoreDataProperties.swift
//  Words
//
//  Created by Sergey Ilyushin on 10/08/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation
import CoreData


extension AlternativeData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlternativeData> {
        return NSFetchRequest<AlternativeData>(entityName: "AlternativeData")
    }

    @NSManaged public var text: String
    @NSManaged public var translate: String

}
