# 🌦️ Weather App

A responsive mobile application built using **Swift** and **SwiftUI** that displays real-time weather information for multiple cities. This project was developed as part of the **2025 Full Stack Assignment** for **Fidenz Technologies**.

## 📑 Table of Contents
- [Features](#-features)
- [Architecture](#-architecture)
- [Technologies Used](#-technologies-used)
- [Demo](#-demo)
- [Getting Started](#-getting-started)
- [API Integration](#-api-integration)
- [Authentication & Authorization](#-authentication--authorization)
- [Caching Strategy](#-caching-strategy)
- [Folder Structure](#-folder-structure)
- [Contributing](#-contributing)

---

## ✨ Features

✅ Real-time weather for a curated list of cities  
✅ Clean, card-based SwiftUI interface for iPhone  
✅ Secure login with Auth0 & email-based MFA
✅ Optimized performance using caching mechanisms  
✅ Restricted access to pre-registered users

## 🧱 Architecture

Follows the **MVVM (Model-View-ViewModel)** pattern:

- **Model**: Data structures (Weather, User)
- **View**: UI built with SwiftUI
- **ViewModel**: State management & data handling

🔧 Includes modular layers for clean, scalable design

## 🛠️ Technologies Used

- **Swift 5** / **SwiftUI** – Core language & UI framework  
- **Auth0 SDK** – Authentication & MFA  
- **URLSession** – API networking  
- **UserDefaults** – Local caching  
- **OpenWeatherMap API** – Weather data provider

---

## 🎥 Demo

To experience the app:

1. Clone the repository
2. Follow the [Getting Started](#-getting-started) steps
3. Log in with `careers@fidenz.com` or another pre-registered user
4. View live weather data

## 🚀 Getting Started

### 🔧 Prerequisites
- Xcode 15+
- Swift 5+
- Auth0 developer account
- OpenWeatherMap API key

### 📥 Installation

1. **Clone the repository**
```bash
git clone https://github.com/your-username/weather-app.git
cd weather-app
```

2. **Open the project in Xcode**
- Use `WeatherApp.xcodeproj` or `WeatherApp.xcworkspace`

3. **Configure API Key**
- Open `Constants.swift` and insert your API key:
```swift
let apiKey = "YOUR_API_KEY"
```

4. **Run the app**
- Choose a target simulator or device
- Click ▶️ **Run** in Xcode

## 🔌 API Integration

Uses OpenWeatherMap's group data endpoint:
```http
GET https://api.openweathermap.org/data/2.5/group?id={CITY_IDS}&units=metric&appid={API_KEY}
```

### 📂 Data Sources
- `cities.json` – City IDs to query

### 🧾 Parsed Fields
- City name
- Temperatures (current, min, max)
- Weather description
- Sunrise / Sunset times
- and more

## 🔐 Authentication & Authorization

- ✅ Login/logout with **Auth0 SDK**  
- 🔐 Email-based MFA enabled  
- 🔄 Secure token refresh managed by SDK

## 🧠 Caching Strategy

- ⏱️ Weather data cached for **5 minutes** using `UserDefaults`
- 🔄 Automatically refreshes data post-expiration
- 🚀 Improves performance and minimizes API calls

---

## 🗂️ Folder Structure

```bash
WeatherApp/
├── Models/               # Data models
├── Views/                # SwiftUI Views
├── ViewModels/           # Business logic & state
├── Services/             # API & Auth services
├── Resources/            # Assets, city JSON
```

---

## 🗂️ Screenshots

![Login screen](https://github.com/user-attachments/assets/7a68ba1d-d658-45b2-9279-3fe422d35574)
![Auth login screen](https://github.com/user-attachments/assets/06618df2-67ab-486c-b9a3-15af2841fedf)
![Auth MFA screen](https://github.com/user-attachments/assets/e8bea678-d19d-46fb-ac66-258ed8ea359f)
![Weather view screen](https://github.com/user-attachments/assets/a9f1349e-2b74-4d46-9d14-25d2683756b6)
![Sign out screen](https://github.com/user-attachments/assets/7d57c346-70cf-4cfb-803e-13281eb1e6d1)

## 🤝 Contributing

Feel free to contribute!

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m 'Add your feature'`
4. Push to the branch: `git push origin feature/your-feature`
5. Open a pull request

---

> Made with ❤️ by Savinu.
> 


