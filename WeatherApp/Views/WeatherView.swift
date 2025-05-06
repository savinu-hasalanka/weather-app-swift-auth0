//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Savinu Hasalanka on 04/05/2025.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var weatherViewModel = WeatherViewModel()
    let gradients: [LinearGradient] = [
        LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing),
        LinearGradient(colors: [.green, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing),
        LinearGradient(colors: [.red, .orange], startPoint: .topLeading, endPoint: .bottomTrailing),
        LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing),
        LinearGradient(colors: [.cyan, .green], startPoint: .topLeading, endPoint: .bottomTrailing),
        LinearGradient(colors: [.black, .gray], startPoint: .topLeading, endPoint: .bottomTrailing),
        LinearGradient(colors: [.orange, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing),
        LinearGradient(colors: [.blue, .pink], startPoint: .topLeading, endPoint: .bottomTrailing)
    ]
    
    var body: some View {
        VStack {
            if weatherViewModel.items.isEmpty {
                Spacer()
                ProgressView()
                Text("Loading ...")
                Spacer()
            } else {
                ScrollView {
                    VStack {
                        ForEach(Array(weatherViewModel.items.enumerated()), id: \.element.cityName) { index, item in
                            WeatherCellHeaderView(weatherData: item, gradient: gradients[index % gradients.count])
                        }
                    }
                    .padding()
                }
            }
        }
        .task {
            await weatherViewModel.fetchWeatherData()
        }
    }
}

#Preview {
    WeatherView()
}
