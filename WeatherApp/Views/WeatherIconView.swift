//
//  WeatherIconView.swift
//  WeatherApp
//
//  Created by Savinu Hasalanka on 05/05/2025.
//

import SwiftUI

struct WeatherIconView: View {
    @State var iconCode: String
    
    var body: some View {
        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(iconCode)@2x.png")) { phase in
            switch phase {
            case .empty:
                // Show a ProgressView while loading
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .padding()
            case .success(let image):
                // Show the image when it finishes loading
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            case .failure:
                // Show a fallback image or something if the loading fails
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 100)
                    .foregroundColor(.red)
            @unknown default:
                // Handle unknown cases
                EmptyView()
            }
        }
    }
}

#Preview {
    WeatherIconView(iconCode: "01d")
}
