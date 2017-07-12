//
//  APIManager.swift
//  WorldTrotter
//
//  Created by JU HO YOON on 2017. 7. 11..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    func getGeoInfoBikeConvenientFacilities(completion: @escaping (_ stations: [(String, Double, Double)]) -> ()) {
        
        guard let url = URL(string: "http://openapi.seoul.go.kr:8088/5441567058796c6c36376c52437676/json/GeoInfoBikeConvenientFacilitiesWGS/1/100") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, res, error) in
            if let jsonData = data {
                guard let json = (try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else { return }
                
                let bikes = json["GeoInfoBikeConvenientFacilitiesWGS"] as? [String: Any]
                var bikeStations:[(String, Double, Double)] = []
                
                if let rows = bikes?["row"] as? [[String: Any]] {
                    for row in rows {
                        guard let latitude = row["LAT"] as? String,
                            let longitude = row["LNG"] as? String,
                            let address = row["ADDRESS"] as? String
                            else { continue }
                        
                        if let lat = Double(latitude), let long = Double(longitude) {
                            bikeStations.append((address, lat, long))
                        }
                    }
                }
                completion(bikeStations)
            }
        }
        task.resume()
    }
}
