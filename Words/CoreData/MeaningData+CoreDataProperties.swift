//
//  MeaningData+CoreDataProperties.swift
//  Words
//
//  Created by Sergey Ilyushin on 10/08/2017.
//  Copyright © 2017 Sergey Ilyushin. All rights reserved.
//

import Foundation
import CoreData


extension MeaningData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MeaningData> {
        return NSFetchRequest<MeaningData>(entityName: "MeaningData")
    }

    @NSManaged public var identifier: Int32
    @NSManaged public var image: Data?
    @NSManaged public var sound: Data?
    @NSManaged public var text: String
    @NSManaged public var translation: String
    @NSManaged public var alternatives: Set<AlternativeData>?

}

// MARK: Generated accessors for alternatives
extension MeaningData {

    @objc(addAlternativesObject:)
    @NSManaged public func addToAlternatives(_ value: AlternativeData)

    @objc(removeAlternativesObject:)
    @NSManaged public func removeFromAlternatives(_ value: AlternativeData)

    @objc(addAlternatives:)
    @NSManaged public func addToAlternatives(_ values: NSSet)

    @objc(removeAlternatives:)
    @NSManaged public func removeFromAlternatives(_ values: NSSet)

}
