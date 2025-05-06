//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Savinu Hasalanka on 04/05/2025.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var items: [WeatherData] = []
    private var cities: [String] = []
    private let weatherService = WeatherService()
    
    func fetchWeatherData() async {
        DispatchQueue.main.async {
            self.items = self.loadCachedWeatherData() ?? []
        }
        
        if !(items.isEmpty) {
            return
        }
        
        loadCityCodesFromJSON()
        weatherService.fetchWeatherData(for: cities, completion: { result in
            switch result {
            case .success(let data):
                let convertedData = self.convertToWeatherData(from: data)
                
                DispatchQueue.main.async {
                    self.items = convertedData
                    self.cacheWeatherData(convertedData)
                }
            case .failure(let error):
                print(error)
                print("error while fetching")
            }
        })
    }
    
    func loadCityCodesFromJSON() {
        guard let url = Bundle.main.url(forResource: "cities", withExtension: "json") else {
            print("❌ Failed to locate cities.json in bundle.")
            cities = []
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let cityListWrapper = try JSONDecoder().decode(CityListWrapper.self, from: data)
            cities = cityListWrapper.List.map { $0.CityCode }
        } catch {
            print("❌ Failed to load or decode cities.json: \(error)")
            cities = []
        }
    }
    
    func convertToWeatherData(from cityWeatherList: [CityWeather]) -> [WeatherData] {
        return cityWeatherList.map { city in
            WeatherData(
                cityName: city.name,
                countryCode: city.sys.country,
                datetime: formatUnixTimestamp(Int64(city.dt), timezoneOffset: city.sys.timezone),
                description: city.weather.first?.description ?? "N/A",
                icon: city.weather.first?.icon ?? "",
                temp: city.main.temp,
                tempMin: city.main.temp_min,
                tempMax: city.main.temp_max,
                pressure: city.main.pressure,
                humidity: city.main.humidity,
                visibility: city.visibility,
                windSpeed: city.wind.speed,
                windDirection: city.wind.deg,
                sunrise: formatUnixTimestampToTime(Int64(city.sys.sunrise)),
                sunset: formatUnixTimestampToTime(Int64(city.sys.sunset))
            )
        }
    }
    
    func formatUnixTimestampToTime(_ timestamp: Int64) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = .current 
        return formatter.string(from: date)
    }
    
    func formatUnixTimestamp(_ timestamp: Int64, timezoneOffset: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        
        // Convert offset in seconds to TimeZone
        guard let timeZone = TimeZone(secondsFromGMT: timezoneOffset) else {
            return "Invalid TimeZone"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma, MMM d"
        formatter.timeZone = timeZone
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        
        return formatter.string(from: date)
    }
    
    func cacheWeatherData(_ weatherData: [WeatherData]) {
        let cached = CachedWeatherData(data: weatherData, timestamp: Date())
        if let encoded = try? JSONEncoder().encode(cached) {
            UserDefaults.standard.set(encoded, forKey: "cachedWeather")
        }
    }
    
    func loadCachedWeatherData() -> [WeatherData]? {
        if let savedData = UserDefaults.standard.data(forKey: "cachedWeather"),
           let cached = try? JSONDecoder().decode(CachedWeatherData.self, from: savedData) {
            
            let elapsed = Date().timeIntervalSince(cached.timestamp)
            if elapsed < 300 { // 5 minutes = 300 seconds
                return cached.data
            }
        }
        return nil
    }
}
