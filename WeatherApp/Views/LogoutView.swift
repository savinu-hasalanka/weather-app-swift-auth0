//
//  SettingsView.swift
//  WeatherApp
//
//  Created by Savinu Hasalanka on 05/05/2025.
//

import SwiftUI

struct LogoutView: View {
    @EnvironmentObject var profileVM: ProfileViewModel
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                HStack(spacing: 30) {
                    UserImage(urlString: profileVM.userProfile.picture)
                    Text("\(profileVM.userProfile.name)")
                        .padding(.bottom, 30)
                }

                Text("Are you sure you want to sign out?")
                    .modifier(TitleStyle())
                Spacer()
                Button("Sign out") {
                    profileVM.logout()
                }
                .buttonStyle(MyButtonStyle())

                Spacer()
            }
            .padding()
        }
    }
}

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


#Preview {
    LogoutView()
}
