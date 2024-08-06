//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Mihail Kolev on 06/08/2024.
//

import Foundation

struct WeatherData: Decodable {
    let hourlyUnits: HourlyUnits
    let hourly: HourlyData

    enum CodingKeys: String, CodingKey {
        case hourlyUnits = "hourly_units"
        case hourly
    }
}

struct HourlyUnits: Decodable {
    let time: String
    let temperature2m: String
    let weathercode: String
    let windspeed10m: String

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2m = "temperature_2m"
        case weathercode
        case windspeed10m = "windspeed_10m"
    }
}

struct HourlyData: Decodable {
    let time: [Date]
    let temperature2m: [Double]
    let weathercode: [WMOWeatherCode]
    let windspeed10m: [Double]

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2m = "temperature_2m"
        case weathercode
        case windspeed10m = "windspeed_10m"
    }
}

enum WMOWeatherCode: Int, Decodable {
    case clearSky = 0
    case mainlyClear = 1
    case partlyCloudy = 2
    case overcast = 3
    case fog = 45
    case depositingRimeFog = 48
    case drizzleLight = 51
    case drizzleModerate = 53
    case drizzleDense = 55
    case freezingDrizzleLight = 56
    case freezingDrizzleDense = 57
    case rainSlight = 61
    case rainModerate = 63
    case rainHeavy = 65
    case freezingRainLight = 66
    case freezingRainHeavy = 67
    case snowFallSlight = 71
    case snowFallModerate = 73
    case snowFallHeavy = 75
    case snowGrains = 77
    case rainShowersSlight = 80
    case rainShowersModerate = 81
    case rainShowersViolent = 82
    case snowShowersSlight = 85
    case snowShowersHeavy = 86
    case thunderstormSlightOrModerate = 95
    case thunderstormWithHailSlight = 96
    case thunderstormWithHailHeavy = 99

    var description: String {
        switch self {
        case .clearSky:
            return "Clear sky"
        case .mainlyClear, .partlyCloudy, .overcast:
            return "Mainly clear, partly cloudy, and overcast"
        case .fog, .depositingRimeFog:
            return "Fog and depositing rime fog"
        case .drizzleLight, .drizzleModerate, .drizzleDense:
            return "Drizzle: Light, moderate, and dense intensity"
        case .freezingDrizzleLight, .freezingDrizzleDense:
            return "Freezing Drizzle: Light and dense intensity"
        case .rainSlight, .rainModerate, .rainHeavy:
            return "Rain: Slight, moderate and heavy intensity"
        case .freezingRainLight, .freezingRainHeavy:
            return "Freezing Rain: Light and heavy intensity"
        case .snowFallSlight, .snowFallModerate, .snowFallHeavy:
            return "Snow fall: Slight, moderate, and heavy intensity"
        case .snowGrains:
            return "Snow grains"
        case .rainShowersSlight, .rainShowersModerate, .rainShowersViolent:
            return "Rain showers: Slight, moderate, and violent"
        case .snowShowersSlight, .snowShowersHeavy:
            return "Snow showers: Slight and heavy"
        case .thunderstormSlightOrModerate:
            return "Thunderstorm: Slight or moderate"
        case .thunderstormWithHailSlight, .thunderstormWithHailHeavy:
            return "Thunderstorm with hail: Slight and heavy"
        }
    }
}
