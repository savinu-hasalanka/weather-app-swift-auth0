//
//  ProfileViewModel.swift
//  WeatherApp
//
//  Created by Savinu Hasalanka on 03/05/2025.
//

import Foundation
import Security
import JWTDecode
import Auth0

class ProfileViewModel: ObservableObject {
    @Published var userProfile = Profile.empty
    @Published var isLoggingIn: Bool = false // indicates if the user process is ongoing
    @Published var isAuthenticated: Bool {
        didSet {
            // Store the value in persistent storage when it changes
            UserDefaults.standard.set(isAuthenticated, forKey: "isAuthenticated")
        }
    }
    
    
    init() {
        self.isAuthenticated = false
        
        // checks for tokens on keychain
        guard let token = getTokenFromKeychain() else {
            return
        }
        
        // validate the token
        isAuthenticated = isTokenValid(token)
        
        // fetch the profile information
        if (isAuthenticated) {
            self.userProfile = self.from(token)
        }
    }
    
    public func checkUserLoginStatus() {
        // checks for tokens on keychain
        guard let token = getTokenFromKeychain() else {
            return
        }
        
        // validate the token
        isAuthenticated = isTokenValid(token)
    }
    
    
    public func login() {
        isLoggingIn = true
        Auth0
            .webAuth()
            .start { result in
                switch result {
                    
                case .failure(let error):
                    print("Failed with: \(error)")
                    self.isLoggingIn = false
                    
                case .success(let credentials):
                    DispatchQueue.main.async {
                            self.isAuthenticated = true
                            self.userProfile = self.from(credentials.idToken)
                            self.storeTokenInKeychain(token: credentials.idToken)
                        }
                    self.isLoggingIn = false
                    
                } // switch
            }
    }
    
    
    public func logout() {
        Auth0
            .webAuth()
            .clearSession { result in
                switch result {
                    
                case .failure(let error):
                    print("Failed with: \(error)")
                    
                case .success:
                    self.isAuthenticated = false
                    self.userProfile = Profile.empty
                    self.deleteTokenFromKeychain()
                } // switch
            }
    }
    
    
    func storeTokenInKeychain(token: String) {
        let data = token.data(using: .utf8)!
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "id_token"
        ]

        // Check if item already exists
        if SecItemCopyMatching(query as CFDictionary, nil) == errSecSuccess {
            // Item exists, update it
            let attributesToUpdate: [String: Any] = [
                kSecValueData as String: data
            ]
            let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
            if status != errSecSuccess {
                print("Failed to update token in Keychain. Status: \(status)")
            }
        } else {
            // Item doesn't exist, add it
            var newQuery = query
            newQuery[kSecValueData as String] = data
            let status = SecItemAdd(newQuery as CFDictionary, nil)
            if status != errSecSuccess {
                print("Failed to add token to Keychain. Status: \(status)")
            }
        }
    }
    
    func deleteTokenFromKeychain() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "id_token"
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        if status != errSecSuccess {
            print("Failed to delete token from Keychain. Status: \(status)")
        }
    }
    
    func getTokenFromKeychain() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "id_token",
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        if status == errSecSuccess, let data = result as? Data, let token = String(data: data, encoding: .utf8) {
            return token
        }
        
        print("Failed to retrieve token from Keychain. Status: \(status)")
        return nil
    }
    
    func isTokenValid(_ token: String) -> Bool{
        print("Checking token")
//        guard let token = getTokenFromKeychain() else {
//            isAuthenticated = false
//            return
//        }
        
        do {
            let jwt = try decode(jwt: token)
            
            // Get the expiration date from the JWT
            if let exp = jwt.expiresAt {
                // Compare the expiration date with the current date
                return exp > Date()
            } else {
                return false // No expiration claim found, consider invalid
            }
        } catch {
            print("Error decoding JWT: \(error)")
            return false // Error decoding means the token is invalid
        }
    }
    
    func from(_ idToken: String) -> Profile {
        guard
            let jwt = try? decode(jwt: idToken),
            let id = jwt.subject,
            let name = jwt.claim(name: "name").string,
            let email = jwt.claim(name: "email").string,
            let emailVerified = jwt.claim(name: "email_verified").boolean,
            let picture = jwt.claim(name: "picture").string,
            let updatedAt = jwt.claim(name: "updated_at").string
        else {
            return Profile.empty
        }
        
        return Profile(
            id: id,
            name: name,
            email: email,
            emailVerified: String(describing: emailVerified),
            picture: picture,
            updatedAt: updatedAt
        )
    }
    
}
