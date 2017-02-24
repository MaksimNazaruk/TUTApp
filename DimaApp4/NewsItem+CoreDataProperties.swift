//
//  NewsItem+CoreDataProperties.swift
//  TUTBYApp
//
//  Created by Maksim Nazaruk on 2/23/17.
//  Copyright © 2017 Dzmitry Miklashevich. All rights reserved.
//

import Foundation
import CoreData


extension NewsItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsItem> {
        return NSFetchRequest<NewsItem>(entityName: "NewsItem");
    }

    @NSManaged public var title: String?
    @NSManaged public var descpiption: String?
    @NSManaged public var pubDate: NSDate?
    @NSManaged public var link: String?
    @NSManaged public var previewImageURL: String?
}
