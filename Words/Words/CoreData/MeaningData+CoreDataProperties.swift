//
//  MeaningData+CoreDataProperties.swift
//  Words
//
//  Created by Sergey Ilyushin on 20/07/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation
import CoreData


extension MeaningData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MeaningData> {
        return NSFetchRequest<MeaningData>(entityName: "MeaningData")
    }

    @NSManaged public var identifier: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var soundUrl: String?
    @NSManaged public var text: String?
    @NSManaged public var translate: String?

}
