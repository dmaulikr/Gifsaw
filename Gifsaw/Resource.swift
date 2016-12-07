//
//  Resource.swift
//  Gifsaw
//
//  Created by Daniel Hooper on 2016-11-08.
//  Copyright © 2016 Daniel Hooper. All rights reserved.
//

import Foundation

struct Resource<A> {
    let url: URL
    let parse: (Data) -> A?
}

extension Resource {
    init(url: URL, parseJSON: @escaping (Any) -> A?) {
        self.url = url
        self.parse = { data in
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            return json.flatMap(parseJSON)
        }
    }
}
