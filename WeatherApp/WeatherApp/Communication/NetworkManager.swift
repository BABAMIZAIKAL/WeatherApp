//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Mihail Kolev on 06/08/2024.
//

import Foundation

class NetworkManager {
    let defaultHeaders = ["Content-Type": "application/json", "Accept-Language": "en"]
    
    private func executeRequest<A: Decodable>(url: String, method: HTTPMethod) async throws -> A {
        guard let requestURL = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = defaultHeaders
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom { decoder in
                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
                guard let date = dateFormatter.date(from: dateString) else { throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date") }

                return date
            }
            let parsed = try decoder.decode(A.self, from: data)

            return parsed
        } catch {
            throw error
        }
    }
}

extension NetworkManager: DataForCityCommunication {
    func getDataForCity(_ city: CityLocation) async throws -> WeatherData {
        let endpoint = Constants.RequestEndpoint.getDataForCity(city: city)
        return try await executeRequest(url: endpoint.url, method: endpoint.method)
    }
}
