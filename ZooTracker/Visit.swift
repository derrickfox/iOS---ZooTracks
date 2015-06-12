//
//  Visit.swift
//  ZooTracker
//
//  Created by Derrick Fox on 6/3/15.
//  Copyright (c) 2015 Derrick Fox. All rights reserved.
//

import Foundation
import CoreData

@objc(Visit)
class Visit: NSManagedObject {

    @NSManaged var time: NSDate
    @NSManaged var temperature: NSNumber
    @NSManaged var sky: String
    @NSManaged var toAnimal: Animal

}
