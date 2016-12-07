//
//  Category.swift
//  Gifsaw
//
//  Created by Daniel Hooper on 2016-11-12.
//  Copyright © 2016 Daniel Hooper. All rights reserved.
//

import Foundation

struct Category {
    let id: String
    let name: String
    let jpg: String
}

extension Category {
    init?(dictionary: JSONDictionary) {
        guard
            let id       = dictionary["id"]     as? String,
            let name     = dictionary["name"]   as? String,
            let images   = dictionary["images"] as? JSONDictionary,
            let original = images["medium"]     as? JSONDictionary,
            let jpg      = original["jpg"]      as? String
        else {
            return nil
        }
        self.id = id
        self.name = name
        self.jpg = jpg
    }
}

extension Category {
    static let all = Resource<[Category]>(url: URL(string: "https://api.popkey.co/v2/categories")!, parseJSON: { data in
        guard let json = data as? [JSONDictionary] else { return nil }
        return json.flatMap(Category.init)
    })
}
