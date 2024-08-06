//
//  WeatherDataInfo.swift
//  WeatherApp
//
//  Created by Mihail Kolev on 06/08/2024.
//

import SwiftUI

struct WeatherDataInfo: View {
    var weatherData: WeatherData
    var refreshEvent: (() -> Void)

    var body: some View {
        List {
            ForEach(0..<weatherData.hourly.time.count, id: \.self) { index in
                VStack(alignment: .leading) {
                    Text("Time: \(weatherData.hourly.time[index].dayMonthTime)")
                    Text("Weather Description: \(weatherData.hourly.weathercode[index].description)")
                    Text("Temperature: \(weatherData.hourly.temperature2m[index], specifier: "%.1f")°C")
                    Text("Windspeed: \(weatherData.hourly.windspeed10m[index], specifier: "%.1f") km/h")
                }
                .padding(.vertical, 5)
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .background(Color.clear)
        .refreshable {
            refreshEvent()
        }
    }
}

#Preview {
    WeatherDataInfo(weatherData: WeatherData(hourlyUnits: HourlyUnits(time: "", temperature2m: "", weathercode: "", windspeed10m: ""),
                                             hourly: HourlyData(time: [], temperature2m: [], weathercode: [], windspeed10m: [])), 
                    refreshEvent: { })
}
