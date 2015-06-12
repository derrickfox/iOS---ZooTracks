//
//  Animal.swift
//  ZooTracker
//
//  Created by Derrick Fox on 6/3/15.
//  Copyright (c) 2015 Derrick Fox. All rights reserved.
//

import Foundation
import CoreData

@objc(Animal)
class Animal: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var toVisit: NSSet

}
