//
//  Popkey.swift
//  Gifsaw
//
//  Created by Daniel Hooper on 2016-11-11.
//  Copyright © 2016 Daniel Hooper. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: Any]

final class PopkeyAPI {
    
    static func load<A>(_ resource: Resource<A>, completion: @escaping (A?) -> ()) {
        let authString = "Basic ZGVtbzplYTdiNjZmYjVlNjZjNjJkNmNmYTQ5ZmJlMGYyN2UwMDJjMjUxNGVlZDljNzVlYTlmNjVlOWQ3NTk4Y2I5YTkw"
        let headers = ["Authorization": authString]
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = headers
        let session = URLSession(configuration: config)
        session.dataTask(with: resource.url) { data, response, error in
            let result = data.flatMap(resource.parse)
            completion(result)
        }.resume()
    }
}
