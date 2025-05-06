//
//  UserImageView.swift
//  WeatherApp
//
//  Created by Savinu Hasalanka on 05/05/2025.
//

import SwiftUI

struct UserImage: View {    
    var urlString: String
    
    var body: some View {
        AsyncImage(url: URL(string: urlString)) { image in
            image
                .frame(maxWidth: 80)
                .clipShape(Circle())
        } placeholder: {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 80)
                .clipShape(Circle())
                .foregroundColor(.blue)
                .opacity(0.5)
        }
        .padding(.bottom, 40)
    }
}

//#Preview {
//    UserImageView()
//}
