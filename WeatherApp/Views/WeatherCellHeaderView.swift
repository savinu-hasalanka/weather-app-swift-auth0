//
//  WeatherCellHeaderView.swift
//  WeatherApp
//
//  Created by Savinu Hasalanka on 05/05/2025.
//

import SwiftUI

struct WeatherCellHeaderView: View {
    @State var weatherData: WeatherData
    @State var gradient: LinearGradient
    
    var body: some View {
        VStack (spacing: 0) {
            HStack (spacing: 55) {
                VStack(spacing: 5) {
                    Text("\(weatherData.cityName), \(weatherData.countryCode)")
                        .font(.system(size: 20, weight: .bold))
                    Text("\(weatherData.datetime)")
                    HStack {
                        WeatherIconView(iconCode: weatherData.icon)
                        Text("\(weatherData.description.capitalized)")
                    }
                    .padding(.top, 12)
                }
                
                
                VStack {
                    Text("\(String(format: "%.0f", weatherData.temp))°C")
                        .font(.system(size: 27, weight: .bold))
                        .padding(.bottom)
                    Text("Temp Min: \(String(format: "%.0f", weatherData.tempMin))°C")
                    Text("Temp Max: \(String(format: "%.0f", weatherData.tempMax))°C")
                }
            }
            .frame(width: 325)
            .font(.system(size: 12))
            .padding()
            .background(gradient)
            
            WeatherCellFooterView(weatherData: weatherData)
        }
        .padding()
        .foregroundStyle(.white)
    }
}

//#Preview {
//    WeatherCellHeaderView(weatherData: WeatherData(
//        cityName: "Colombo",
//        countryCode: "LK",
//        datetime: "",
//        description: "Clear Sky",
//        icon: "01d",
//        temp: 30.0,
//        tempMin: 28.0,
//        tempMax: 32.0,
//        pressure: 1010,
//        humidity: 70,
//        visibility: 10000,
//        windSpeed: 5.0,
//        windDirection: 90,
//        sunrise: "1633292400",
//        sunset: "1633345800",
//        gradient: LinearGradient(colors: [.red, .orange], startPoint: .top, endPoint: .bottom)
//    )
//}
