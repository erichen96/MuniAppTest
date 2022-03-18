//
//  RouteConfig.swift
//  MuniApp
//
//  Created by Eric Chen on 3/17/22.
//

import Foundation


struct Stop: Codable {
    let tag: String
    let title: String
}

struct RouteConfig: Codable {
    struct Route: Codable {
        let stop: [Stop]
        let direction: [Direction]
    }
    let route: Route
}

struct Direction: Codable {
    struct StopTag: Codable {
        let tag: String
    }
    let stop: [StopTag]
}




//MOVE to PredictionConfig File
struct Minutes: Codable {
    let min: Int
//    let sec: Int 
}


struct PredictionConfig: Codable {
    struct Time: Codable {
        let minutes: [Minutes]
    }
    let predictions: Time
    
}
