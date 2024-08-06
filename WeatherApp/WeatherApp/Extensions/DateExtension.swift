//
//  DateExtension.swift
//  WeatherApp
//
//  Created by Mihail Kolev on 06/08/2024.
//

import Foundation

extension Date {
    var dayMonthTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        return dateFormatter.string(from: self)
    }
}

