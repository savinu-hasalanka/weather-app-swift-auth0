//
//  Profile.swift
//  WeatherApp
//
//  Created by Savinu Hasalanka on 03/05/2025.
//

import JWTDecode

struct Profile {
    let id: String
    let name: String
    let email: String
    let emailVerified: String
    let picture: String
    let updatedAt: String
}


extension Profile {
    static var empty: Self {
        return Profile(
            id: "",
            name: "",
            email: "",
            emailVerified: "",
            picture: "",
            updatedAt: ""
        )
    }
}
