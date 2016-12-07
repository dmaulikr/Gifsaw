//
//  Media.swift
//  Gifsaw
//
//  Created by Daniel Hooper on 2016-11-11.
//  Copyright © 2016 Daniel Hooper. All rights reserved.
//

import UIKit

struct MediaItem {
    let id: String
    let width: Int
    let height: Int
    let gif: String
    var jpg: String
    var size: CGSize {
        get {
            if width > height { // We will want to rotate the image if true, so we return a size with the width and height swapped
                return CGSize(width: height, height: width)
            } else {
                return CGSize(width: width, height: height)
            }
        }
    }
}

extension MediaItem {
    init?(dictionary: JSONDictionary) {
        guard
            let id       = dictionary["id"]     as? String,
            let source   = dictionary["source"] as? JSONDictionary,
            let height   = source["height"]     as? Int,
            let width    = source["width"]      as? Int,
            let images   = dictionary["images"] as? JSONDictionary,
            let original = images["original"]   as? JSONDictionary,
            let gif      = original["gif"]      as? String,
            let jpg      = original["jpg"]      as? String
        else {
            return nil
        }
        
        self.id = id
        self.width = width
        self.height = height
        self.gif = gif
        self.jpg = jpg
        
        if let medium = images["medium"]  as? String {
            self.jpg = medium
        }
        
        if let small = images["small"] as? String {
            self.jpg = small
        }
    }
}
