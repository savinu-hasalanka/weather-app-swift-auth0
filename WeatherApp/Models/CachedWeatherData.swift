//
//  CachedWeatherData.swift
//  WeatherApp
//
//  Created by Savinu Hasalanka on 05/05/2025.
//

import Foundation

struct CachedWeatherData: Codable {
    let data: [WeatherData]
    let timestamp: Date
}
