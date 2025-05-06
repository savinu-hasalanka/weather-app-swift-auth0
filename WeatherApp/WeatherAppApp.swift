//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Savinu Hasalanka on 03/05/2025.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false
    @StateObject private var profileVM = ProfileViewModel() // Initialize ProfileViewModel once
    
    
    var body: some Scene {
        WindowGroup {
            if isAuthenticated {
                MainTabView() // User is logged in
                    .onAppear { print(isAuthenticated) }
            } else {
                LoginView() // Show login screen
                    .onAppear { print(isAuthenticated) }
            }
        }
        .environmentObject(profileVM)
        
    }
}
