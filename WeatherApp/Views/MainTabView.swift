//
//  MainTabView.swift
//  WeatherApp
//
//  Created by Savinu Hasalanka on 05/05/2025.
//

import SwiftUI

enum Tab: String {
    case Weather
    case SignOut = "Sign Out"
}

struct MainTabView: View {
    @EnvironmentObject var profileVM: ProfileViewModel
    @State private var selectedTab: Tab = .Weather
    @State private var timer = Timer.publish(every: 300, on: .main, in: .common).autoconnect()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                WeatherView()
                    .navigationTitle("Weather App")
            }
            .tabItem {
                Label("Weather", systemImage: "cloud.sun")
            }
            .tag(Tab.Weather)
            
            NavigationStack {
                LogoutView()
                    .navigationTitle("Sign out")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Sign out", systemImage: "door.right.hand.open")
            }
            .tag(Tab.SignOut)
            .ignoresSafeArea()
        }
        .onAppear {
            profileVM.checkUserLoginStatus()
        }
        .onReceive(timer) { _ in
            // Check user login status every time the timer fires (every 5 minutes)
            profileVM.checkUserLoginStatus()
        }
    }
}

#Preview {
    MainTabView()
}
