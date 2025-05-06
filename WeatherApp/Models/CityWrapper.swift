//
//  CityWrapper.swift
//  WeatherApp
//
//  Created by Savinu Hasalanka on 04/05/2025.
//

import Foundation

struct CityListWrapper: Decodable {
    let List: [City]
}

struct City: Decodable {
    let CityCode: String
    let CityName: String
    let Temp: String
    let Status: String
}
