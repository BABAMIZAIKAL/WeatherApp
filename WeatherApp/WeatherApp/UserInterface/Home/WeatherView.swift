//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Mihail Kolev on 06/08/2024.
//

import SwiftUI

struct WeatherView: View {
    @StateObject var viewModel: WeatherViewModel

    var body: some View {
        ZStack {
            backgroundColor

            VStack {
                titleView
                
                citiesListing
                
                if let weatherData = viewModel.weatherData {
                    WeatherDataInfo(weatherData: weatherData, refreshEvent: { viewModel.selectCity(viewModel.selectedCity) })
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    ProgressView("Loading...")
                }
                Spacer()
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }

    var titleView: some View {
        Text("WeatherApp")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.black)
    }

    var citiesListing: some View {
        HStack(spacing: 12) {
            ForEach(viewModel.cities, id: \.name) { city in
                Text(city.name)
                    .foregroundStyle(viewModel.selectedCity.name == city.name ? Color.blue : Color.gray)
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(viewModel.selectedCity.name == city.name ? Color.blue : Color.gray, lineWidth: 1)
                    )
                    .onTapGesture {
                        viewModel.selectCity(city)
                    }
            }
            .padding(.horizontal, 4)
        }
    }

    var backgroundColor: some View {
        LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.2), Color.yellow.opacity(0.1)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}

#Preview {
    WeatherView(viewModel: WeatherViewModel(networkManager: NetworkManager()))
}
