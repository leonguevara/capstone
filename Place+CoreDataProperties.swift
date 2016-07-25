//
//  Place+CoreDataProperties.swift
//  capstone
//
//  Created by León Felipe Guevara Chávez on 7/21/16.
//  Copyright © 2016 León Felipe Guevara Chávez. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Place {

    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var name: String?

}
