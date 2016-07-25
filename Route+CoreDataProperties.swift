//
//  Route+CoreDataProperties.swift
//  capstone
//
//  Created by León Felipe Guevara Chávez on 7/19/16.
//  Copyright © 2016 León Felipe Guevara Chávez. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Route {

    @NSManaged var end_latitude: NSNumber?
    @NSManaged var end_longitude: NSNumber?
    @NSManaged var name: String?
    @NSManaged var start_latitude: NSNumber?
    @NSManaged var start_longitude: NSNumber?
    @NSManaged var image: NSData?

}
