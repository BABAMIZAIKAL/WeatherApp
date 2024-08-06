//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Mihail Kolev on 06/08/2024.
//

import Foundation

class WeatherViewModel: ObservableObject {
    private let networkManager: NetworkManager

    @Published var weatherData: WeatherData?
    @Published var errorMessage: String?
    @Published var selectedCity: CityLocation

    var cities: [CityLocation] = []

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager

        if let savedCity = UserDefaults.standard.data(forKey: "selectedCity"),
           let decodedCity = try? JSONDecoder().decode(CityLocation.self, from: savedCity) {
            self.selectedCity = decodedCity
        } else {
            self.selectedCity = CityLocation(name: "Sofia", lat: 42.70, lon: 23.32)
        }

        self.fetchCities()
        self.selectCity(selectedCity)
    }
    
    func fetchWeather(for city: CityLocation) {
        Task {
            do {
                let data = try await networkManager.getDataForCity(city)
                DispatchQueue.main.async {
                    self.weatherData = data
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    private func fetchCities() {
        cities = [CityLocation(name: "Sofia", lat: 42.70, lon: 23.32),
                  CityLocation(name: "Plovdiv", lat: 42.15, lon: 24.75),
                  CityLocation(name: "Burgas", lat: 42.51, lon: 27.47)]
    }

    func selectCity(_ city: CityLocation) {
        self.selectedCity = city
        self.fetchWeather(for: city)

        if let encodedCity = try? JSONEncoder().encode(city) {
            UserDefaults.standard.set(encodedCity, forKey: "selectedCity")
        }
    }
}
