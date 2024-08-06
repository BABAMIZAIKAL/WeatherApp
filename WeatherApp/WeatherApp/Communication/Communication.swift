//
//  Communication.swift
//  WeatherApp
//
//  Created by Mihail Kolev on 06/08/2024.
//

import Foundation

protocol DataForCityCommunication {
    func getDataForCity(_ city: CityLocation) async throws -> WeatherData
}
