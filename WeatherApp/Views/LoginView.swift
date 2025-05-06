//
//  ContentView.swift
//  WeatherApp
//
//  Created by Savinu Hasalanka on 03/05/2025.
//

import SwiftUI
import Auth0

struct LoginView: View {
    @EnvironmentObject var profileVM: ProfileViewModel
    
    var body: some View {
        if profileVM.isLoggingIn {
            ProgressView()
        } else {
            VStack {
                Text("Weather App")
                    .modifier(TitleStyle())
                Button("Log in") {
                    profileVM.login()
                }
                .buttonStyle(MyButtonStyle())
            }
        }
    }
    
    // MARK: View modifiers
    // --------------------
    
    struct TitleStyle: ViewModifier {
        let titleFontBold = Font.title.weight(.bold)
        let navyBlue = Color(red: 0, green: 0, blue: 0.5)
        
        func body(content: Content) -> some View {
            content
                .font(titleFontBold)
                .foregroundColor(navyBlue)
                .padding()
        }
    }
    
    struct MyButtonStyle: ButtonStyle {
        let navyBlue = Color(red: 0, green: 0, blue: 0.5)
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .background(navyBlue)
                .foregroundColor(.white)
                .clipShape(Capsule())
        }
    }
    
}


#Preview {
    LoginView()
}
