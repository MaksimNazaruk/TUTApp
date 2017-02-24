//
//  Parser.swift
//  DimaApp4
//
//  Created by Dzmitry Miklashevich on 1/24/17.
//  Copyright © 2017 Dzmitry Miklashevich. All rights reserved.
//

import Foundation
import UIKit

class Parser: NSObject, XMLParserDelegate {

    var parser: XMLParser?
    var currentNewsItem: NewsItem?
    var currentElement = ""
    var currentAttributes = [String:String]()
    var currentChars = ""
    
    var dateFormatter: DateFormatter!
    
    var parsedNews = [NewsItem]()

    override init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss ZZZ"
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI namespaceURL: String?, qualifiedName qName: String?, attributes attributeDict: [String:String]){
        
        currentElement = elementName
        currentAttributes = attributeDict
        currentChars = ""
        
        if elementName == "item" {
            currentNewsItem = NewsItem()
        }
        
        if elementName == "enclosure" {
            if let type = currentAttributes["type"] {
                if type.contains("image") {
                    if let imageURL = currentAttributes["url"] {
                        currentNewsItem?.previewImageURL = imageURL
                    }
                }
            }
        }
        
        if elementName == "media:content" {
            if let type = currentAttributes["type"] {
                if type.contains("image") {
                    if let imageURL = currentAttributes["url"] {
                        if currentNewsItem?.imageURLs == nil {
                           currentNewsItem?.imageURLs = [String]()
                        }
                        currentNewsItem?.imageURLs?.append(imageURL)
                    }
                }
            }
        }
    
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        currentChars += string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        switch elementName {
        case "title":
            currentNewsItem?.title = currentChars
        case "description":
            currentNewsItem?.description = currentChars.stringWithStrippedHTMLTags()
        case "link":
            currentNewsItem?.link = currentChars
        case "pubDate":
            currentNewsItem?.pubDate = dateFormatter.date(from: currentChars)
        case "item":
            if let parsedItem = currentNewsItem {
                parsedNews.append(parsedItem)
                currentNewsItem = nil
            }
        default:
            break
        }
 
    }
    
    func parseData(data: Data) -> [NewsItem]{
        parser?.abortParsing()
        parser = XMLParser(data: data)
        parser?.delegate = self
        parser?.parse()
        return parsedNews
    }
    
}


