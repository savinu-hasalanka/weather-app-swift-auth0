//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Savinu Hasalanka on 04/05/2025.
//

import Foundation

struct WeatherData: Codable {
    let cityName: String
    let countryCode: String
    let datetime: String
    let description: String
    let icon: String
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    let visibility: Int
    let windSpeed: Double
    let windDirection: Int
    let sunrise: String
    let sunset: String
}
