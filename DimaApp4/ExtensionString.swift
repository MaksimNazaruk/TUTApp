//
//  ExtensionString.swift
//  DimaApp4
//
//  Created by Dzmitry Miklashevich on 1/27/17.
//  Copyright © 2017 Dzmitry Miklashevich. All rights reserved.
//

import Foundation

extension String {
    
    public func stringWithStrippedHTMLTags() -> String {
        
        let regexp = try? NSRegularExpression(pattern: "<[^>]+>", options: [])
        let fullStringRange = NSRange(location: 0, length: self.characters.count)
        let strippedString = regexp?.stringByReplacingMatches(in: self, options: [], range: fullStringRange, withTemplate: "")
        return strippedString ?? self
    }
}
