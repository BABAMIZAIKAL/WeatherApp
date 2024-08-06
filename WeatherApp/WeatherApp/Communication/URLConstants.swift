//
//  URLConstants.swift
//  WeatherApp
//
//  Created by Mihail Kolev on 06/08/2024.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}


protocol URLConvertible {
    var url: String { get }
}

protocol HTTPMethodConvertible {
    var method: HTTPMethod { get }
}

struct Constants {
    enum RequestEndpoint {
        case getDataForCity(city: CityLocation)

        static var serverURL = "https://api.open-meteo.com/v1/"
    }
}

extension Constants.RequestEndpoint: URLConvertible {
    var url: String {
        switch self {
        case let .getDataForCity(city: city):
            return Self.serverURL + "forecast?latitude=\(city.lat)&longitude=\(city.lon)&hourly=temperature_2m,weathercode,windspeed_10m"
        }
    }
}

extension Constants.RequestEndpoint: HTTPMethodConvertible {
    var method: HTTPMethod {
        switch self {
        case .getDataForCity:
            return .GET
        }
    }
}
