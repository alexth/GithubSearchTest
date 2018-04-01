//
//  Repository+CoreDataProperties.swift
//  GithubSearchTest
//
//  Created by Alex Golub on 4/1/18.
//  Copyright © 2018 Alex Golub. All rights reserved.
//
//

import Foundation
import CoreData


extension Repository {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Repository> {
        return NSFetchRequest<Repository>(entityName: "Repository")
    }

    @NSManaged public var forks: Int64
    @NSManaged public var language: String?
    @NSManaged public var name: String?
    @NSManaged public var repositoryDescription: String?
    @NSManaged public var stars: Int64
    @NSManaged public var updatedDate: NSDate?

}
