//
//  RoutesResponse.swift
//  MuniApp
//
//  Created by Eric Chen on 3/17/22.
//

import Foundation

struct RoutesResponse: Codable {
    let copyright: String
    let route: [Route]
}

struct Route: Codable {
    let tag: String
    let title: String
}
    
struct Time: Codable {
    let minutes: [Minutes]
    
}
//    enum Keys: CodingKey {
//        case tag, title
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: Keys.self)
//        tag = try container.decode(String.self, forKey: .tag)
//        title = try container.decode(String.self, forKey: .title)
//    }
    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: Keys.self)
//        try container.encode(title, forKey: .title)
//        try container.encode(tag, forKey: .tag)
//    }
//}
