//
//  WeatherResponseDTO.swift
//  WeatherApp
//
//  Created by Savinu Hasalanka on 03/05/2025.
//

import Foundation

struct WeatherResponse: Decodable {
    let list: [CityWeather]
}

struct CityWeather: Decodable, Identifiable {
    let id: Int
    let name: String
    let coord: Coordinate
    let sys: Sys
    let weather: [WeatherCondition]
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let visibility: Int

    struct Coordinate: Decodable {
        let lon: Double
        let lat: Double
    }

    struct Sys: Decodable {
        let country: String
        let timezone: Int
        let sunrise: Int
        let sunset: Int
    }

    struct WeatherCondition: Decodable {
        let description: String
        let icon: String
    }

    struct Main: Decodable {
        let temp: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let humidity: Int
        let feels_like: Double
    }

    struct Wind: Decodable {
        let speed: Double
        let deg: Int
    }

    struct Clouds: Decodable {
        let all: Int
    }
}
