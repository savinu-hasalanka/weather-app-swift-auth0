//
//  WeatherCellFooterView.swift
//  WeatherApp
//
//  Created by Savinu Hasalanka on 05/05/2025.
//

import SwiftUI

struct WeatherCellFooterView: View {
    @State var weatherData: WeatherData
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text("Pressure: \(weatherData.pressure)hPa")
                Text("Humidity: \(weatherData.humidity)%")
                Text("Visibility: \(weatherData.visibility)km")
            }
            
            VStack {
                Rectangle()
                    .fill(Color.white)
                        .frame(width: 1, height: 50)
                        .padding(.horizontal, 8)
            }
            
            VStack (alignment: .center) {
                Image(systemName: "location")
                    .font(.system(size: 17))
                    .padding(.bottom, 3)
                Text("\(String(format: "%.1f", weatherData.windSpeed))m/s \(weatherData.windDirection) Degree")
            }
            
            VStack {
                Rectangle()
                    .fill(Color.white)
                        .frame(width: 1, height: 50)
                        .padding(.horizontal, 8)
            }
            
            VStack (alignment: .leading) {
                Text("Sunrise: \(weatherData.sunrise)")
                Text("Sunset: \(weatherData.sunset)")
            }
        }
        .frame(width: 325)
        .font(.system(size: 9))
        .foregroundStyle(.white)
        .padding()
        .background(Color(red: 57/255, green: 59/255, blue: 70/255))
    }
}

#Preview {
    WeatherCellFooterView(weatherData: WeatherData(
        cityName: "Colombo",
        countryCode: "LK",
        datetime: "",
        description: "Clear Sky",
        icon: "01d",
        temp: 30.0,
        tempMin: 28.0,
        tempMax: 32.0,
        pressure: 1010,
        humidity: 70,
        visibility: 10000,
        windSpeed: 5.0,
        windDirection: 90,
        sunrise: "1633292400",
        sunset: "1633345800"
    ))
}
