//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Mihail Kolev on 06/08/2024.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    private let networkManager = NetworkManager()
    
    var body: some Scene {
        WindowGroup {
            WeatherView(viewModel: WeatherViewModel(networkManager: networkManager))
        }
    }
}
