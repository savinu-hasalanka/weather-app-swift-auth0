//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Savinu Hasalanka on 03/05/2025.
//

import Foundation

class WeatherService {
    func fetchWeatherData(for cities:[String], completion: @escaping (Result<[CityWeather], Error>) -> Void) {
        let apiKey = APIConstants.apiKey
        let cityIds = cities.joined(separator: ",")
        let baseUrl = "https://api.openweathermap.org/data/2.5/group"
        
        let endPoint = "\(baseUrl)?id=\(cityIds)&units=metric&appid=\(apiKey)"
                
        guard let url = URL(string: endPoint) else {
            return completion(.failure(URLError(.badURL)))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(error))
            }
            
            guard let data = data else {
                return completion(.failure(URLError(.badServerResponse)))
            }
            
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(weatherResponse.list))
            } catch {
                completion(.failure(error))
            }
        }.resume()
        
        
    }
}
