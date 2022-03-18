//
//  Networking.swift
//  MuniApp
//
//  Created by Eric Chen on 3/17/22.
//

import Foundation


struct Networking {
    let baseURLString = "https://retro.umoiq.com/service/publicJSONFeed?"
    
    func fetchRoutes(callback: @escaping ([Route]) -> ()){
        //This would block user interactions, we want to do this on a background queue.
        // We can use the global queue for this.
        
        guard let url = URL(string:"\(baseURLString)command=routeList&a=sf-muni") else {
            return
        }
        
        //Request with trailing closure
        let task = URLSession.shared.dataTask(with: url){ maybeData, maybeResponse, maybeError in
            guard let data: Data = maybeData else {
                return
            }
//            print(NSString(string: String(data: data, encoding: .utf8)!))
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(RoutesResponse.self, from: data)
                let routes: [Route] = response.route
                callback(routes)
            } catch {
                
            }
            
        }
        task.resume()
    }
    
    //New and fancy way of making request!
    func fetchRouteConfig(routeTag: String) async throws -> RouteConfig {
        let url = URL(string: "\(baseURLString)command=routeConfig&a=sf-muni&r=\(routeTag)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(RouteConfig.self, from: data)
    }
    
    func fetchPredictionConfig(routeTag: String, stopId: String) async throws -> PredictionConfig {
        print(stopId)
        print(routeTag)
        let url = URL(string:"\(baseURLString)command=predictions&a=sf-muni&stopId=\(stopId)&routeTag=\(routeTag)")!
        print(url)
        let(data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(PredictionConfig.self, from: data)
    }
}
